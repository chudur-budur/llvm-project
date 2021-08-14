#!/bin/bash

echo "==================== Configuring LLVM ===================="

mkdir -p build

cd build

#   -DCMAKE_C_COMPILER=clang-11 \
#   -DCMAKE_CXX_COMPILER=clang++-11 \
#   -DCMAKE_LINKER=/usr/lib/llvm-11/bin/ld.lld \

cmake -G Ninja ../llvm \
    -DBUILD_SHARED_LIBS=True \
    -DCMAKE_INSTALL_PREFIX=$HOME/opt/llvm \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_LINKER=/usr/bin/ld \
    -DLLVM_BUILD_LLVM_DYLIB=OFF \
    -DLLVM_ENABLE_PROJECTS=mlir \
    -DLLVM_BUILD_EXAMPLES=ON \
    -DLLVM_TARGETS_TO_BUILD="X86;AArch64;NVPTX;AMDGPU" \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_ENABLE_LLD=OFF \
    -DMLIR_ENABLE_CUDA_RUNNER=ON \
    -DMLIR_INCLUDE_TESTS=ON \
    -DMLIR_INCLUDE_INTEGRATION_TESTS=ON

echo "==================== Building and Installing LLVM ===================="

cmake --build . --target check-mlir
cmake --build . --target install
