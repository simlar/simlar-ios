#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r  BUILD_DIR=${1:?"Please give liblinphone dir as first parameter"}
declare -r  GIT_HASH=${2:-"unknown"}

declare -r DST="$(dirname $(readlink -f $0))"

cd "${BUILD_DIR}/linphone-iphone"

## workaround for recompiling
rm -rf submodules/build-i386-apple-darwin/externals/gsm
rm -rf submodules/build-armv7-apple-darwin/externals/gsm
rm -rf submodules/build-armv7s-apple-darwin/externals/gsm
rm -rf submodules/build-aarch64-apple-darwin/externals/gsm

cd submodules/build
make all
make sdk
cd ../..

cd ..

unzip -o $(find "linphone-iphone/submodules" -maxdepth 1 -name liblinphone-iphone-sdk\*.zip)

rm -rf liblinphone-tutorials
rm -rf liblinphone-sdk/apple-darwin/share/

rm -rf "${DST}/liblinphone-sdk"
mv liblinphone-sdk "${DST}/"
echo "liblinphone build successfull with git hash: ${GIT_HASH}"
