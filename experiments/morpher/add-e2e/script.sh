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
soda-opt -soda-extract-arguments-to-xml='using-bare-ptr=true' 07-host.mlir

# generate CGRA accelerated code (conventional way)
soda-opt -outline-cgra-code -generate-cgra-accelcode='gen-morpher-kernel=true' 06-locating.mlir > 08-accel.mlir

# lower to llvm mlir
soda-opt -lower-all-to-llvm='use-bare-ptr-memref-call-conv=1' 07-host.mlir > 09-host-llvm.mlir

soda-opt -lower-all-to-llvm='use-bare-ptr-memref-call-conv=1' 08-accel.mlir > 10-accel-llvm.mlir

# lower to llvm ir
mlir-translate --mlir-to-llvmir 09-host-llvm.mlir > 11-model.ll

mlir-translate --mlir-to-llvmir 10-accel-llvm.mlir > 12-accel.ll

target_function="generic_0"
function morpher_dfg_generator() {
    local MORPHER_PATH=~/workspace/Morpher/Morpher_DFG_Generator/build/
    local MORPHER_SRC_PATH=~/workspace/Morpher/Morpher_DFG_Generator/
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
    opt -load $MORPHER_PATH/src/libdfggenPass.so -debug -fn ${target_function} -nobanks 2 -banksize 2048 -type PartPred -S -o ${instr_ll_file} --dfggen  -enable-new-pm=0 ${opt_ll_file}

    dot -Tpdf ${target_function}_PartPredDFG.dot -o ${target_function}_PartPredDFG.pdf

    if [ -f instrumentation.ll ]; then
       echo "Skip generating instrumentation.ll"
    else
        echo "Code instrumentation, generating instrumentation.ll"
        clang -target x86_64-unknown-linux-gnu -fPIE -c -emit-llvm -S ${MORPHER_SRC_PATH}/src/instrumentation/instrumentation.cpp -o instrumentation.ll
    fi

    echo "llvm link, generating ${final_ll_file}"
    llvm-link ${instr_ll_file} instrumentation.ll -o ${final_ll_file}

    echo "llc, generating ${final_obj_file}"
    llc -relocation-model=pic -filetype=obj ${final_ll_file} -o ${final_obj_file}

    #echo "generating final binary ${final_bin_file}"
    #clang++ -m64 -pie ${final_obj_file} -o ${final_bin_file}

    #echo "Executing ${final_bin_file}"
    #./${final_bin_file}


    rm ${ll_file}
    rm ${opt_ll_file}
    rm ${instr_ll_file}
    rm ${final_ll_file}
    rm ${final_obj_file}
    #rm ${final_bin_file}
}

function morpher_cgra_mapper() {
    local MAPPER_PATH=~/workspace/Morpher/Morpher_CGRA_Mapper
    local json_arch="hycube_original_mem.json"
    local json_arch_before_memupdate="hycube_original_updatemem.json"
    local numberofbanks=2
    local banksize=2048
    local init_II=0
    local mapping_method=0

    echo "updating memory allocation"
    python $MAPPER_PATH/update_mem_alloc.py $MAPPER_PATH/json_arch/${json_arch_before_memupdate} ${target_function}_mem_alloc.txt ${banksize} ${numberofbanks} ${json_arch}

    echo "===Morpher CGRA Mapper=="
    $MAPPER_PATH/build/src/cgra_xml_mapper -d ${target_function}_PartPredDFG.xml -x 4 -y 4 -j $json_arch -i ${init_II} -t HyCUBE_4REG -m ${mapping_method}

}


morpher_dfg_generator 12-accel.ll
morpher_cgra_mapper
