export PATH=${PATH}":/usr/local/cuda/bin:$HOME/.ghcup/bin:$HOME/.cabal/bin"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}":/usr/local/cuda/lib64:/usr/local/cuda/nvvm/lib64:/home/kenhkan/present/lib/hasktorch/deps/libtorch/lib/"
export LIBRARY_PATH=${LD_LIBRARY_PATH}

stack build .
stack run
