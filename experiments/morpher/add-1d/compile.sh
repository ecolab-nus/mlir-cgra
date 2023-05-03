#!/usr/bin/env sh
SODA_OPT=/home/huiying/mlir-cgra/build/bin/soda-opt
MORPHER_PATH=~/Morpher/Morpher_DFG_Generator/build/
MORPHER_SRC_PATH=~/Morpher/Morpher_DFG_Generator/

if [ $# -ne 1 ]; then
    echo "Usage: ./compile.sh [mlir_file]"
    exit 0
fi

input_file_param=$1
input_file=${input_file_param%.mlir}

mlir_llvm_file=${input_file}-llvm.mlir
ll_file=${input_file}.ll
opt_ll_file=${input_file}-opt.ll
instr_ll_file=${input_file}-instrument-opt.ll
final_ll_file=${input_file}-final.ll
final_obj_file=${input_file}-final.o
final_bin_file=${input_file}-final

rm *.log
rm *.dot
rm *.xml
rm *.txt
rm ${mlir_llvm_file}
rm ${ll_file}
rm ${opt_ll_file}
rm ${instr_ll_file}
rm ${final_ll_file}
rm ${final_obj_file}
rm ${final_bin_file}

$SODA_OPT --mlir-print-ir-after-all --lower-all-to-llvm='use-bare-ptr-memref-call-conv=1'  ${input_file_param} > ${mlir_llvm_file}

echo "Translating ${mlir_llvm_file} to ${ll_file}"
mlir-translate --mlir-to-llvmir ${mlir_llvm_file} > ${ll_file}

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

echo "Clean up generated files"
#rm ${mlir_llvm_file}
#rm ${ll_file}
#rm ${opt_ll_file}
#rm ${instr_ll_file}
#rm ${final_ll_file}
#rm ${final_obj_file}
#rm ${final_bin_file}
#rm *.log
#rm *.dot
#rm *.xml
#rm *.txt
