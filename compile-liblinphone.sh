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
    -DLINPHONESDK_PLATFORM=IOS \
    -DLINPHONESDK_IOS_ARCHS="arm64, armv7, x86_64" \
    -DCMAKE_BUILD_TYPE=Release \
    -DENABLE_ADVANCED_IM=ON \
    -DENABLE_AMRNB=OFF \
    -DENABLE_AMRWB=OFF \
    -DENABLE_ASSETS=ON \
    -DENABLE_BV16=OFF \
    -DENABLE_CAMERA2=OFF \
    -DENABLE_CODEC2=OFF \
    -DENABLE_CSHARP_WRAPPER=OFF \
    -DENABLE_CXX_WRAPPER=OFF \
    -DENABLE_DB_STORAGE=ON \
    -DENABLE_DEBUG_LOGS=OFF \
    -DENABLE_DOC=OFF \
    -DENABLE_FFMPEG=OFF \
    -DENABLE_G726=OFF \
    -DENABLE_G729=OFF \
    -DENABLE_G729B_CNG=OFF \
    -DENABLE_GPL_THIRD_PARTIES=OFF \
    -DENABLE_GSM=OFF \
    -DENABLE_GTK_UI=OFF \
    -DENABLE_ILBC=OFF \
    -DENABLE_ISAC=OFF \
    -DENABLE_JAVA_WRAPPER=OFF \
    -DENABLE_JAZZY_DOC=OFF \
    -DENABLE_JPEG=ON \
    -DENABLE_LIME=OFF \
    -DENABLE_LIME_X3DH=ON \
    -DENABLE_MBEDTLS=ON \
    -DENABLE_MDNS=OFF \
    -DENABLE_MKV=OFF \
    -DENABLE_NLS=OFF \
    -DENABLE_NON_FREE_CODECS=OFF \
    -DENABLE_OPENH264=OFF \
    -DENABLE_OPUS=ON \
    -DENABLE_PCAP=OFF \
    -DENABLE_POLARSSL=OFF \
    -DENABLE_QRCODE=ON \
    -DENABLE_RELATIVE_PREFIX=OFF \
    -DENABLE_RTP_MAP_ALWAYS_IN_SDP=OFF \
    -DENABLE_SILK=OFF \
    -DENABLE_SOCI_MYSQL=OFF \
    -DENABLE_SPEEX=ON \
    -DENABLE_SQLITE=ON \
    -DENABLE_SRTP=ON \
    -DENABLE_SWIFT_WRAPPER=ON \
    -DENABLE_TOOLS=OFF \
    -DENABLE_TUNNEL=OFF \
    -DENABLE_UNIT_TESTS=OFF \
    -DENABLE_UNMAINTAINED=OFF \
    -DENABLE_UPDATE_CHECK=OFF \
    -DENABLE_V4L=OFF \
    -DENABLE_VCARD=OFF \
    -DENABLE_VIDEO=ON \
    -DENABLE_VPX=ON \
    -DENABLE_WEBRTC_AEC=OFF \
    -DENABLE_WEBRTC_AECM=OFF \
    -DENABLE_WEBRTC_VAD=OFF \
    -DENABLE_XML2=ON \
    -DENABLE_ZLIB=ON \
    -DENABLE_ZRTP=ON

cmake --build .

## copy sdk
rm -rf "${DEST_DIR}"
mkdir "${DEST_DIR}"
gcp linphone-sdk.podspec "${DEST_DIR}/"
unzip -o $(gfind . -maxdepth 1 -name linphone-sdk-ios\*.zip) -d "${DEST_DIR}/"

echo "liblinphone build successfull with git hash: ${GIT_HASH}"
echo "integrate it with:"
echo "  pod install"
