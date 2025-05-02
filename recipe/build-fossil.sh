#!/usr/bin/env bash
set -eux

# shellcheck disable=SC2155
export CC="$(basename "${CC}")"

ln -s "${BUILD_PREFIX}/bin/${CC}" "${BUILD_PREFIX}/bin/cc"
ln -s "${BUILD_PREFIX}/bin/python" "${PREFIX}/bin/python"

emsdk install latest
emsdk activate latest

# shellcheck disable=SC1091
. "${CONDA_EMSDK_DIR}/emsdk_env.sh"

./configure \
  --prefix="${PREFIX}" \
  --build="${BUILD}" \
  --host="${HOST}" \
  --with-tcl="${PREFIX}" \
  --with-zlib="${PREFIX}/include" \
  --with-openssl="${PREFIX}" \
  --disable-internal-sqlite \
  --json

make "-j${CPU_COUNT}" wasm
make "-j${CPU_COUNT}"

make install --debug
