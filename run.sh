LIBTORCH_PATH=~/hasktorch/deps/libtorch/lib
LIBTOKENIZER_PATH=~/hasktorch/deps/libtokenizers/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH/usr/local/cuda-11.8/nvvm/lib64/:$LIBTORCH_PATH

stack build --copy-bins --local-bin-path bin/ --extra-include-dirs=$LIBTORCH_PATH/include/torch/csrc/api/include --extra-include-dirs=$LIBTORCH_PATH/include --extra-lib-dirs=$LIBTORCH_PATH/lib --extra-lib-dirs=$LIBTOKENIZER_PATH/lib --profile --library-profiling --no-library-stripping --executable-profiling --no-executable-stripping --no-strip --trace --ghc-options=-fprof-auto-exported --ghc-options=-g --ghc-options=-O0

gdb bin/acc-tch-issue
