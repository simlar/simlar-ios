#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r  BUILD_DIR=${1:?"Please give liblinphone dir as first parameter"}
declare -r  GIT_HASH=${2:-"unknown"}

declare -r CMAKE_BUILD_DIR="${BUILD_DIR}/linphone-sdk-build_$(date '+%Y%m%d_%H%M%S')"
mkdir "${CMAKE_BUILD_DIR}"
cd "${CMAKE_BUILD_DIR}"

cmake "${BUILD_DIR}/linphone-sdk" \
    -DLINPHONESDK_PLATFORM=IOS \
    -DLINPHONESDK_IOS_ARCHS="arm64, armv7, x86_64" \
    -DENABLE_AAUDIO=OFF \
    -DENABLE_AMRNB=OFF \
    -DENABLE_AMRWB=OFF \
    -DENABLE_BV16=OFF \
    -DENABLE_CODEC2=OFF \
    -DENABLE_CSHARP_WRAPPER=OFF \
    -DENABLE_CXX_WRAPPER=OFF \
    -DENABLE_DEBUG_LOGS=OFF \
    -DENABLE_DOC=OFF \
    -DENABLE_FFMPEG=OFF \
    -DENABLE_G726=OFF \
    -DENABLE_G729=OFF \
    -DENABLE_G729B_CNG=OFF \
    -DENABLE_GPL_THIRD_PARTIES=OFF \
    -DENABLE_GSM=ON \
    -DENABLE_GTK_UI=OFF \
    -DENABLE_ILBC=ON \
    -DENABLE_ISAC=ON \
    -DENABLE_JAVA_WRAPPER=OFF \
    -DENABLE_JPEG=ON \
    -DENABLE_LIME=OFF \
    -DENABLE_LIME_X3DH=ON \
    -DENABLE_MBEDTLS=ON \
    -DENABLE_MDNS=OFF \
    -DENABLE_MKV=ON \
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
    -DENABLE_SPEEX=ON \
    -DENABLE_SRTP=ON \
    -DENABLE_TOOLS=OFF \
    -DENABLE_TUNNEL=OFF \
    -DENABLE_UNIT_TESTS=OFF \
    -DENABLE_UNMAINTAINED=OFF \
    -DENABLE_UPDATE_CHECK=ON \
    -DENABLE_VCARD=ON \
    -DENABLE_VIDEO=ON \
    -DENABLE_VPX=ON \
    -DENABLE_WEBRTC_AEC=OFF \
    -DENABLE_WEBRTC_AECM=OFF \
    -DENABLE_WEBRTC_VAD=OFF \
    -DENABLE_ZRTP=ON

cmake --build .


echo "liblinphone build successfull with git hash: ${GIT_HASH}"
echo " integrate it with:"
echo " PODFILE_PATH=${CMAKE_BUILD_DIR} pod install"
