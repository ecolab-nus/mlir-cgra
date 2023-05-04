# perform finalization
set -e
#mlir-opt -convert-tensor-to-linalg -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors   -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize   -finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params  input.mlir > 04-finalized.mlir
#mlir-opt --mlir-print-ir-after-all -convert-tensor-to-linalg -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors   -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize   -finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params  input.mlir > 04-finalized.mlir


# perform tiling (same rule across all the operations)
#soda-opt --linalg-tiling-for-cgra=cgra-configs=4,4,1024,1024,1024,1024 04-finalized.mlir > 05-tiled.mlir

# locating target operations that will be offloaded onto CGRA
mlir-opt --test-transform-dialect-interpreter --canonicalize 05-tiled.mlir > 05-promoted.mlir

soda-opt --convert-linalg-matmul-to-cgra --convert-linalg-generic-to-cgra 05-promoted.mlir > 06-locating.mlir

# generate host with offloading operations onto CGRA
soda-opt -outline-cgra-code -generate-cgra-hostcode='gen-morpher-kernel=true' 06-locating.mlir > 07-host.mlir

# generate xml file
soda-opt -soda-extract-arguments-to-xml 07-host.mlir

# generate CGRA accelerated code (conventional way)
soda-opt -outline-cgra-code -generate-cgra-accelcode='gen-morpher-kernel=true' 06-locating.mlir > 08-accel.mlir

# lower to llvm mlir
soda-opt -lower-all-to-llvm='use-bare-ptr-memref-call-conv=1' 07-host.mlir > 09-host-llvm.mlir

soda-opt -lower-all-to-llvm='use-bare-ptr-memref-call-conv=1' 08-accel.mlir > 10-accel-llvm.mlir

# lower to llvm ir
mlir-translate --mlir-to-llvmir 09-host-llvm.mlir > 11-model.ll

mlir-translate --mlir-to-llvmir 10-accel-llvm.mlir > 12-accel.ll


function morpher_dfg_generator() {
    local MORPHER_PATH=~/Morpher/Morpher_DFG_Generator/build/
    local MORPHER_SRC_PATH=~/Morpher/Morpher_DFG_Generator/
    local ll_file=$1
    local opt_ll_file="opt_$1"
    local instr_ll_file="instr_$1"
    local final_ll_file="final_$1"
    local prefix=${1%.ll}
    local final_obj_file="$prefix.o"
    local final_bin_file="$prefix.bin"


    echo "===Morpher DFG generator ${ll_file}==="

    echo "Optimizing ${ll_file} to ${opt_ll_file}"
    opt -gvn -mem2reg -memdep -memcpyopt -lcssa -loop-simplify -licm -loop-deletion -indvars -simplifycfg -mergereturn -indvars -dce ${ll_file} -S -o ${opt_ll_file}

    echo "Generating DFG (array_add_PartPredDFG.xml/dot) and data layout (array_add_mem_alloc.txt), generating ${instr_ll_file}"
    opt -load $MORPHER_PATH/src/LLVMDfggen.so -fn array_add -nobanks 2 -banksize 2048 -type PartPred -S -o ${instr_ll_file} --dfggen  -enable-new-pm=0 ${opt_ll_file}


    if [ -f instrumentation.ll ]; then
       echo "Skip generating instrumentation.ll"
    else
        echo "Code instrumentation, generating instrumentation.ll"
        clang -target i386-unknown-linux-gnu -c -emit-llvm -S ${MORPHER_SRC_PATH}/src/instrumentation/instrumentation.cpp -o instrumentation.ll
    fi

    echo "llvm link, generating ${final_ll_file}"
    llvm-link ${instr_ll_file} instrumentation.ll -o ${final_ll_file}

    echo "llc, generating ${final_obj_file}"
    llc -filetype=obj ${final_ll_file} -o ${final_obj_file}

    echo "generating final binary ${final_bin_file}"
    clang++ -m32 ${final_obj_file} -o ${final_bin_file}

    echo "Executing ${final_bin_file}"
    ./${final_bin_file}


    rm ${ll_file}
    rm ${opt_ll_file}
    rm ${instr_ll_file}
    rm ${final_ll_file}
    rm ${final_obj_file}
    rm ${final_bin_file}
}



morpher_dfg_generator 12-accel.ll
