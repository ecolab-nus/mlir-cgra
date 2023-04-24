#!/usr/bin/env sh

# generate CGRA accelerated code (for both conventional mapped kernels and user predefined kernels)
soda-opt -lower-all-to-llvm='use-bare-ptr-memref-call-conv=true' 01-linalg.mlir > 02-host-llvm.mlir
