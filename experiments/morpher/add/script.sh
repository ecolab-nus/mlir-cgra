#!/usr/bin/env sh
# perform operation fusion
#mlir-opt --linalg-fuse-elementwise-ops 02-linalg.mlir > 03-fused.mlir

export PATH=~/llvm-project-cgra/build/bin/:$PATH
# perform finalization
mlir-opt --canonicalize -convert-tensor-to-linalg -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors   -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize   -finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params   --canonicalize -cse 03-fused.mlir > 04-finalized.mlir

# perform tiling (same rule across all the operations)
SODA_OPT=/home/huiying/mlir-cgra/build/bin/soda-opt

$SODA_OPT --linalg-tiling-for-cgra=cgra-configs=4,4,1024,1024,1024,1024 04-finalized.mlir > 05-tiled.mlir

# locating target operations that will be offloaded onto CGRA
$SODA_OPT --convert-linalg-matmul-to-cgra --convert-linalg-generic-to-cgra 05-tiled.mlir > 06-locating.mlir

# generate host with offloading operations onto CGRA
$SODA_OPT -outline-cgra-code -generate-cgra-hostcode 06-locating.mlir > 07-host.mlir

# generate CGRA accelerated code (conventional way)
$SODA_OPT -outline-cgra-code -generate-cgra-accelcode 06-locating.mlir > 08-accel.mlir

# lower to llvm mlir
$SODA_OPT -lower-all-to-llvm 07-host.mlir > 09-host-llvm.mlir
$SODA_OPT -lower-all-to-llvm 08-accel.mlir > 10-accel-llvm.mlir

# lower to llvm ir
mlir-translate --mlir-to-llvmir 09-host-llvm.mlir > 11-model.ll
mlir-translate --mlir-to-llvmir 10-accel-llvm.mlir > 12-accel.ll

# generate obj
llc -filetype=obj 11-model.ll
llc -filetype=obj 12-accel.ll

# compile for simulation
echo "Compile"
clang++ main.cpp 11-model.o 12-accel.o -I../../../sim/ ../../../sim/*.cpp CustomizedRuntime.cpp -o simulate

# run CGRA-Mapper to get the execution cycles for each generic kernel, and register in the simulator
# llvm-as 12-accel.ll
# opt -load ../build/src/libmapperPass.so -mapperPass 12-accel.bc
