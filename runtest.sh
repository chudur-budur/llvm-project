LLVM_PROJECT=/localdisk/$USER/llvm-project
IMEX_PROJECT=/localdisk/$USER/frameworks.ai.mlir.mlir-extensions

IMEX_RUNNER=$LLVM_PROJECT/build/bin/imex-runner.py
TEST_PATH=$IMEX_PROJECT/test/Integration/Dialect/XeGPU/

IMEX_ENABLE_LARGE_REG_FILE=1 python $IMEX_RUNNER --requires=l0-runtime -i %s \
    --pass-pipeline-file=$TEST_PATH/xegpu-to-func-vc.pp \
    --runner imex-cpu-runner -e main \
    --entry-point-result=void \
    --shared-libs=%irunner_utils,%mlir_runner_utils,%mlir_c_runner_utils,%levelzero_runtime --filecheck
// RUN: IMEX_ENABLE_LARGE_REG_FILE=1 %python_executable %imex_runner --requires=sycl-runtime -i %s --pass-pipeline-file=%p/xegpu-to-func-vc.pp \
// RUN:                                        --runner imex-cpu-runner -e main \
// RUN:                                        --entry-point-result=void \
// RUN:                                        --shared-libs=%irunner_utils,%mlir_runner_utils,%mlir_c_runner_utils,%sycl_runtime --filecheck
