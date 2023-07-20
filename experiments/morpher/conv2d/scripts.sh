set -e

soda-opt --transform-ops-interp="transform-file=./transform-ops/tile-fuse.mlir" --canonicalize 01-linalg.mlir > 02-tiled.mlir
# soda-opt -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors --one-shot-bufferize='allow-return-allocs=true bufferize-function-boundaries=true' 02-tiled.mlir > 03-bufferized.mlir

# bufferize
soda-opt -linalg-init-tensor-to-alloc-tensor  --transform-ops-interp="transform-file=./transform-ops/to-memref.mlir" --canonicalize 02-tiled.mlir > 03-buf.mlir

soda-opt --transform-ops-interp="transform-file=./transform-ops/promote.mlir" --canonicalize 03-buf.mlir > 04-promoted.mlir

soda-opt --convert-linalg-conv-to-cgra --convert-linalg-generic-to-cgra 04-promoted.mlir > 06-locating.mlir

# generate host with offloading operations onto CGRA
soda-opt -outline-cgra-code -generate-cgra-hostcode='gen-morpher-kernel=true' 06-locating.mlir > 07-host.mlir


# generate xml file
soda-opt -soda-extract-arguments-to-xml 07-host.mlir

# generate CGRA accelerated code (conventional way)
soda-opt -outline-cgra-code -generate-cgra-accelcode='gen-morpher-kernel=true' 06-locating.mlir > 08-accel.mlir


soda-opt -lower-all-to-llvm='use-bare-ptr-memref-call-conv=1' 08-accel.mlir > 10-accel-llvm.mlir

# lower to llvm mlir
# soda-opt -lower-all-to-llvm='use-bare-ptr-memref-call-conv=1' 07-host.mlir > 09-host-llvm.mlir


# lower to llvm ir
# mlir-translate --mlir-to-llvmir 09-host-llvm.mlir > 11-model.ll

mlir-translate --mlir-to-llvmir 10-accel-llvm.mlir > 12-accel.ll

function morpher_mapper() {
    local MORPHER_MAPPER_PATH=~/Morpher/Morpher_CGRA_Mapper/
    local json_arch=${MORPHER_MAPPER_PATH}/json_arch/hycube_original_updatemem.json
    local update_mem_alloc_python=${MORPHER_MAPPER_PATH}/update_mem_alloc.py

    local mem_alloc_txt_file=$1_mem_alloc.txt
    python $update_mem_alloc_python $json_arch $mem_alloc_txt_file 2048 2 hycube_original_mem.json
    echo ">>> Generating binary file for hycube simulator."
    bash ${MORPHER_MAPPER_PATH}/src/build/cgra_xml_mapper -d $1_PartPredDFG.xml -x 4 -y 4 -j hycube_original_mem.json -i 0 -t HyCUBE_4REG -m 0
}

#morpher_mapper generic_0

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
    opt -load $MORPHER_PATH/src/libdfggenPass.so -fn generic_0 -nobanks 2 -banksize 2048 -type PartPred -S -o ${instr_ll_file} --dfggen  -enable-new-pm=0 ${opt_ll_file}


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
