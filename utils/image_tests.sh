#! /usr/bin/env sh

CMAKE_PRESET="gcc${1}-relwithdebinfo"

echo "Building ${CMAKE_PRESET}"

git -c http.sslverify=false clone --recursive --shallow-submodules --depth=1 -b add_generic_relwithdebinfo https://github.com/vjankraemer/sil-kit-ci.git sil-kit

cd sil-kit

cmake --preset $CMAKE_PRESET
cmake --build --preset $CMAKE_PRESET
ctest --preset $CMAKE_PRESET
