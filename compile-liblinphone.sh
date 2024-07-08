#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r  BUILD_DIR=${1:?"Please give liblinphone dir as first parameter"}
declare -r  GIT_HASH=${2:-"unknown"}

declare -r DEST_DIR="$(dirname $(greadlink -f $0))/liblinphone"

declare -r CMAKE_BUILD_DIR="${BUILD_DIR}/linphone-sdk/linphone-sdk-build_$(date '+%Y%m%d_%H%M%S')"
cd "${BUILD_DIR}/linphone-sdk"

cmake \
    --preset=ios-sdk \
    -G Ninja \
    -B "${CMAKE_BUILD_DIR}" \
    -DLINPHONESDK_IOS_ARCHS="arm64, x86_64" \
    -DENABLE_AAUDIO=OFF \
    -DENABLE_GPL_THIRD_PARTIES=ON \
    -DENABLE_NON_FREE_FEATURES=ON \
    -DENABLE_PQCRYPTO=ON \
    -DENABLE_GSM=OFF \
    -DENABLE_ILBC=OFF \
    -DENABLE_ISAC=OFF \
    -DENABLE_MKV=OFF \
    -DENABLE_VCARD=OFF

cmake --build "${CMAKE_BUILD_DIR}" --config RelWithDebInfo

## copy sdk
rm -rf "${DEST_DIR}"
mkdir "${DEST_DIR}"
gcp "${CMAKE_BUILD_DIR}"/linphone-sdk.podspec "${DEST_DIR}/"
unzip -o $(gfind "${CMAKE_BUILD_DIR}" -maxdepth 1 -name linphone-sdk-\*.zip) -d "${DEST_DIR}/"

echo "liblinphone build successfull with git hash: ${GIT_HASH}"
echo "integrate it with:"
echo "  pod install"
