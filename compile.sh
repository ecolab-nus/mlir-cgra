#!/usr/bin/env sh

BUILD_DIR=~/llvm-project-16/debug

mkdir build && cd build
cmake -G Ninja .. \
    -DLLVM_EXTERNAL_LIT=$BUILD_DIR/bin/llvm-lit \
    -DMLIR_DIR=$BUILD_DIR/lib/cmake/mlir
