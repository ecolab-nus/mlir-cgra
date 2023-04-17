#!/usr/bin/env bash

MORPHER_PATH=~/Morpher/Morpher_DFG_Generator/build/

# accel-simple-map.mlir is modified from 08-accel.mlir, remove map0 so that we can enable bare-ptr optimization

soda-opt -lower-all-to-llvm="use-bare-ptr-memref-call-conv=true" accel-simple-map.mlir > accel-bare.mlir

# lower to ll
echo "lower to ll"
mlir-translate --mlir-to-llvmir accel-bare.mlir > accel-bare.ll


echo "Optimizing"
opt -gvn -mem2reg -memdep -memcpyopt -lcssa -loop-simplify -licm -loop-deletion -indvars -simplifycfg -mergereturn -indvars  accel-bare.ll -S -o accel-bare-opt.ll

echo "Generating DFG (array_add_PartPredDFG.xml/dot) and data layout (array_add_mem_alloc.txt)"
opt -load $MORPHER_PATH/src/LLVMDfggen.so -fn generic_0 -nobanks 2 -banksize 2048 -type PartPred -S -o accel-bare-opt_instrument.ll --dfggen  -enable-new-pm=0  accel-bare-opt.ll
