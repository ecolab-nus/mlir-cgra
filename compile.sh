#!/usr/bin/env bash


if [[ -z "${WORKSPACE_DIR}" ]]; then
    export WORKSPACE_DIR=$(pwd)
fi

function install_llvm() {
    echo "=============== Start Compile LLVM ==============="
    echo $LLVM_PATH
    if [[ -z "${LLVM_PATH}" ]]; then
        export LLVM_PATH="${WORKSPACE_DIR}/llvm-project"
    fi

    git clone git@github.com:llvm/llvm-project.git ${LLVM_PATH}

    pushd ${LLVM_PATH}
    gco 99020b3c73c1e22fa388be8fd0c44391d40b3a38 -b llvm-16

    mkdir build
    pushd build
    cmake -G Ninja ../llvm -DLLVM_ENABLE_PROJECTS="mlir;polly" -DLLVM_BUILD_EXAMPLES=ON -DLLVM_TARGETS_TO_BUILD="Native;NVPTX;AMDGPU" -DCMAKE_BUILD_TYPE=Debug 

    cmake --build . --target check-mlir
    pushd
    pushd
    echo "=============== Finished Compile LLVM ==============="
}

function install_mlir_cgra() {
    mkdir build 
    cd build
    cmake -G Ninja .. \
      -DLLVM_EXTERNAL_LIT=$LLVM_PATH/build/bin/llvm-lit \
      -DMLIR_DIR=$LLVM_PATH/build/lib/cmake/mlir
}

function install_morpher() {
    echo "=============== Start Compile LLVM ==============="
    if [[ -z "${MORPHER_PATH}" ]]; then
        export MORPHER_PATH="${WORKSPACE_DIR}/third_party/Morpher"
    fi
    git clone --recurse-submodules  https://github.com/ecolab-nus/Morpher.git  $MORPHER_PATH
    pushd $MORPHER_PATH
    ./build_all.sh
    popd
}

#install_llvm
#install_morpher
install_mlir_cgra


