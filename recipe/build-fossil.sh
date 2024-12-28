#!/usr/bin/env bash
set -eux

if [[ "${target_platform}" == "linux-ppc64le" ]]; then
  export BUILD_OR_PPC64LE="ppc64le-linux"
else
  export BUILD_OR_PPC64LE="${BUILD}"
fi


# shellcheck disable=SC2155
export CC="$(basename "${CC}")"

ln -s "${BUILD_PREFIX}/bin/${CC}" "${BUILD_PREFIX}/bin/cc"

export PIKCHR_WASM=extsrc/pikchr.wasm

if [[ -f "${PIKCHR_WASM}" ]]; then
  echo "${PIKCHR_WASM} exists, not doing any emsdk setup"
else
  # TODO: maybe pass in via script_env?
  emsdk install latest
  emsdk activate latest
  # shellcheck disable=SC1091
  . "${CONDA_EMSDK_DIR}/emsdk_env.sh"
fi

./configure --prefix="${PREFIX}" \
  --build="${BUILD_OR_PPC64LE}" \
  --host="${HOST}" \
  --with-tcl="${PREFIX}" \
  --with-zlib="${PREFIX}/include" \
  --with-openssl="${PREFIX}" \
  --disable-internal-sqlite \
  --json

# runs without error if already exists
make "-j${CPU_COUNT}" wasm
make "-j${CPU_COUNT}"

make install --debug
