#!/usr/bin/env bash
set -eux

CC="$(basename "$CC")"

ln -s $BUILD_PREFIX/bin/$CC $BUILD_PREFIX/bin/cc

export PIKCHR_WASM=extsrc/pikchr.wasm

if [[ -f "$PIKCHR_WASM" ]]; then
  echo "$PIKCHR_WASM exists, not doing any emsdk setup"
else
  # TODO: maybe pass in via script_env?
  emsdk install latest
  emsdk activate latest
  . ${CONDA_EMSDK_DIR}/emsdk_env.sh
fi

./configure --prefix=${PREFIX} \
  --build=${BUILD} \
  --host=${HOST} \
  --disable-internal-sqlite \
  --with-tcl=${PREFIX} \
  --with-zlib=${PREFIX}/include \
  --with-openssl=${PREFIX} \
  --json \
  CFLAGS="${CFLAGS} -I${PREFIX}/include" \
  LDFLAGS="${LDFLAGS} -L${PREFIX}/lib" \

# runs without error if already exists
make -j${CPU_COUNT} wasm
make -j${CPU_COUNT}

make install --debug
