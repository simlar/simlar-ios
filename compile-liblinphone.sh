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

./prepare.py -c
./prepare.py 'all' \
	-DENABLE_OPENH264=OFF \
	-DENABLE_G729B_CNG=OFF \
	-DENABLE_AMRNB=OFF \
	-DENABLE_H263=OFF \
	-DENABLE_RTP_MAP_ALWAYS_IN_SDP=OFF \
	-DENABLE_BV16=OFF \
	-DENABLE_PACKAGING=OFF \
	-DENABLE_AMRWB=OFF \
	-DENABLE_VCARD=OFF \
	-DENABLE_GSM=OFF \
	-DENABLE_DEBUG_LOGS=OFF \
	-DENABLE_MBEDTLS=ON \
	-DENABLE_GPL_THIRD_PARTIES=ON \
	-DENABLE_ILBC=OFF \
	-DENABLE_OPUS=ON \
	-DENABLE_DOC=OFF \
	-DENABLE_ISAC=OFF \
	-DENABLE_SRTP=ON \
	-DENABLE_G729=OFF \
	-DENABLE_SILK=Off \
	-DENABLE_X264=OFF \
	-DENABLE_H263P=OFF \
	-DENABLE_VIDEO=ON \
	-DENABLE_PCAP=OFF \
	-DENABLE_POLARSSL=OFF \
	-DENABLE_FFMPEG=OFF \
	-DENABLE_UNIT_TESTS=ON \
	-DENABLE_NON_FREE_CODECS=OFF \
	-DENABLE_ZRTP=ON \
	-DENABLE_CODEC2=OFF \
	-DENABLE_WEBRTC_AEC=OFF \
	-DENABLE_MKV=OFF \
	-DENABLE_TUNNEL=OFF \
	-DENABLE_VPX=ON \
	-DENABLE_SPEEX=ON \
	-DENABLE_NLS=OFF \
	-DENABLE_MPEG4=OFF

make
make sdk

## copy sdk
rm -rf "${DEST_DIR}"
mkdir "${DEST_DIR}"
gcp -a liblinphone-sdk/apple-darwin/ "${DEST_DIR}/"
rm -rf "${DEST_DIR}/apple-darwin/share/"

echo "liblinphone build successfull with git hash: ${GIT_HASH}"
