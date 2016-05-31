#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r  BUILD_DIR=${1:?"Please give liblinphone dir as first parameter"}
declare -r  GIT_HASH=${2:-"unknown"}

declare -r DEST_DIR="$(dirname $(greadlink -f $0))/liblinphone-sdk"

cd "${BUILD_DIR}/linphone-iphone"

## workaround for recompiling
rm -rf submodules/build-i386-apple-darwin/externals/gsm
rm -rf submodules/build-armv7-apple-darwin/externals/gsm
rm -rf submodules/build-armv7s-apple-darwin/externals/gsm
rm -rf submodules/build-aarch64-apple-darwin/externals/gsm

./prepare.py 'all' -DENABLE_AMRNB=NO -DENABLE_AMRWB=NO -DENABLE_SILK=NO -DENABLE_G729=NO -DENABLE_OPENH264=NO
make
make sdk

## copy sdk
rm -rf "${DEST_DIR}"
mkdir "${DEST_DIR}"
cp -a liblinphone-sdk/apple-darwin/ "${DEST_DIR}/"
rm -rf "${DEST_DIR}/apple-darwin/share/"

echo "liblinphone build successfull with git hash: ${GIT_HASH}"
