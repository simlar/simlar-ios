#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r  BUILD_DIR=${1:?"Please give liblinphone dir as first parameter"}
declare -r  GIT_HASH=${2:-"unknown"}

declare -r DEST_DIR="$(dirname $(readlink -f $0))"

cd "${BUILD_DIR}/linphone-iphone"

## workaround for recompiling
rm -rf submodules/build-i386-apple-darwin/externals/gsm
rm -rf submodules/build-armv7-apple-darwin/externals/gsm
rm -rf submodules/build-armv7s-apple-darwin/externals/gsm
rm -rf submodules/build-aarch64-apple-darwin/externals/gsm

./prepare.py 'all' -DENABLE_AMRNB=NO -DENABLE_AMRWB=NO -DENABLE_SILK=NO -DENABLE_G729=NO -DENABLE_OPENH264=NO
make
make sdk

cd ..

unzip -o $(find "linphone-iphone/" -maxdepth 1 -name liblinphone-iphone-sdk\*.zip)

rm -rf liblinphone-tutorials
rm -rf liblinphone-sdk/apple-darwin/share/

rm -rf "${DEST_DIR}/liblinphone-sdk"
mv liblinphone-sdk "${DEST_DIR}/"
echo "liblinphone build successfull with git hash: ${GIT_HASH}"
