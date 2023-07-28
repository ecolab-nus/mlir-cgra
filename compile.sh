#!/usr/bin/env sh

BUILD_DIR=~/llvm-project-16/debug

WORKSPACE_DIR="~/"

function install_llvm() {
    echo "=============== Start Compile LLVM ==============="
    if [[ -z "${LLVM_PATH}" ]];
        LLVM_PATH="${WORKSPACE_DIR}/llvm-project"
    fi

    git clone git@github.com:llvm/llvm-project.git $LLVM_PATH

    cd ${LLVM_PATH}
    mkdir build
    cd build
    cmake -G Ninja ../llvm \
       -DLLVM_ENABLE_PROJECTS=mlir;polly \
       -DLLVM_BUILD_EXAMPLES=ON \
       -DLLVM_TARGETS_TO_BUILD="Native;NVPTX;AMDGPU" \
       -DCMAKE_BUILD_TYPE=Debug \
       -DLLVM_ENABLE_ASSERTIONS=ON

    cmake --build . --target check-mlir
    echo "=============== Finished Compile LLVM ==============="
}

mkdir build && cd build
cmake -G Ninja .. \
    -DLLVM_EXTERNAL_LIT=$BUILD_DIR/bin/llvm-lit \
    -DMLIR_DIR=$BUILD_DIR/lib/cmake/mlir
