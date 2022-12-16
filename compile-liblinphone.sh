#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r  BUILD_DIR=${1:?"Please give liblinphone dir as first parameter"}
declare -r  GIT_HASH=${2:-"unknown"}

declare -r DEST_DIR="$(dirname $(greadlink -f $0))/liblinphone"

declare -r CMAKE_BUILD_DIR="${BUILD_DIR}/linphone-sdk-build_$(date '+%Y%m%d_%H%M%S')"
mkdir "${CMAKE_BUILD_DIR}"
cd "${CMAKE_BUILD_DIR}"

cmake "${BUILD_DIR}/linphone-sdk" \
    -G Ninja \
    -DLINPHONESDK_PLATFORM=IOS \
    -DLINPHONESDK_IOS_ARCHS="arm64, armv7, x86_64" \
    -DENABLE_AAUDIO=OFF \
    -DENABLE_GPL_THIRD_PARTIES=ON \
    -DENABLE_GSM=OFF \
    -DENABLE_ILBC=OFF \
    -DENABLE_ISAC=OFF \
    -DENABLE_MKV=OFF \
    -DENABLE_VCARD=OFF

cmake --build . --config RelWithDebInfo

## copy sdk
rm -rf "${DEST_DIR}"
mkdir "${DEST_DIR}"
gcp linphone-sdk.podspec "${DEST_DIR}/"
unzip -o $(gfind . -maxdepth 1 -name linphone-sdk-ios\*.zip) -d "${DEST_DIR}/"

echo "liblinphone build successfull with git hash: ${GIT_HASH}"
echo "integrate it with:"
echo "  pod install"
