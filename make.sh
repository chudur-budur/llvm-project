#!/bin/bash
echo "==================== Configuring LLVM ===================="

mkdir -p build || exit 1

cd build

#   -DCMAKE_C_COMPILER=clang-11 \
#   -DCMAKE_CXX_COMPILER=clang++-11 \
#   -DCMAKE_LINKER=/usr/lib/llvm-11/bin/ld.lld \
#   -DLLVM_TARGETS_TO_BUILD="X86;ARM;NVPTX;AMDGPU;SPIRV" \
#   -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="AArch64;RISCV" \
#   -DLLVM_ENABLE_LLD=OFF \
#   -DMLIR_ENABLE_CUDA_RUNNER=ON \
#   -DMLIR_INCLUDE_INTEGRATION_TESTS=ON
#   -DCMAKE_C_COMPILER=/usr/bin/clang \
#   -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
#   -DLLVM_CCACHE_BUILD=ON \
#   -DCMAKE_C_COMPILER_LAUNCHER=ccache \
#   -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
#   -DCMAKE_LINKER=/usr/bin/lld \

cmake -G Ninja ../llvm \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;lldb;polly;mlir" \
    -DCMAKE_INSTALL_PREFIX=$HOME/opt/llvm \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DBUILD_SHARED_LIBS=True \
    -DLLVM_CCACHE_BUILD=ON \
    -DCMAKE_C_COMPILER_LAUNCHER=ccache \
    -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
    -DCMAKE_C_COMPILER=/usr/bin/clang \
    -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
    -DCMAKE_LINKER=/usr/bin/lld \
    -DLLVM_BUILD_LLVM_DYLIB=OFF \
    -DLLVM_BUILD_EXAMPLES=ON \
    -DLLVM_TARGETS_TO_BUILD="X86;ARM;SPIRV" \
    -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="AArch64;RISCV" \
    -DMLIR_INCLUDE_TESTS=ON

echo "==================== Building and Installing LLVM ===================="

# cmake --build . --target check-mlir
cmake --build . --target install -j 5
