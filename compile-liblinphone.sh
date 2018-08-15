#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r  BUILD_DIR=${1:?"Please give liblinphone dir as first parameter"}
declare -r  GIT_HASH=${2:-"unknown"}

declare -r BASE_DIR="$(dirname $(greadlink -f $0))"
declare -r DEST_DIR="${BASE_DIR}/liblinphone-sdk"
declare -r ROOT_CA="${BASE_DIR}/Simlar/resources/rootca.pem"

cd "${BUILD_DIR}/linphone-iphone"

## workaround for recompiling
rm -rf submodules/build-i386-apple-darwin/externals/gsm
rm -rf submodules/build-armv7-apple-darwin/externals/gsm
rm -rf submodules/build-armv7s-apple-darwin/externals/gsm
rm -rf submodules/build-aarch64-apple-darwin/externals/gsm

./prepare.py -c
./prepare.py \
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
	-DENABLE_GPL_THIRD_PARTIES=ON \
	-DENABLE_GSM=OFF \
	-DENABLE_GTK_UI=OFF \
	-DENABLE_H263=OFF \
	-DENABLE_H263P=OFF \
	-DENABLE_ILBC=OFF \
	-DENABLE_ISAC=OFF \
	-DENABLE_JAVA_WRAPPER=OFF \
	-DENABLE_JPEG=ON \
	-DENABLE_LIME=ON \
	-DENABLE_LIME_X3DH=OFF \
	-DENABLE_MBEDTLS=ON \
	-DENABLE_MDNS=OFF \
	-DENABLE_MKV=OFF \
	-DENABLE_MPEG4=OFF \
	-DENABLE_NLS=NO \
	-DENABLE_NON_FREE_CODECS=OFF \
	-DENABLE_OPENH264=OFF \
	-DENABLE_OPUS=ON \
	-DENABLE_PCAP=OFF \
	-DENABLE_POLARSSL=OFF \
	-DENABLE_QRCODE=OFF \
	-DENABLE_RTP_MAP_ALWAYS_IN_SDP=OFF \
	-DENABLE_SILK=OFF \
	-DENABLE_SOCI=OFF \
	-DENABLE_SPEEX=ON \
	-DENABLE_SRTP=ON \
	-DENABLE_STATIC_ONLY=OFF \
	-DENABLE_TOOLS=OFF \
	-DENABLE_TUNNEL=OFF \
	-DENABLE_UNIT_TESTS=OFF \
	-DENABLE_UNMAINTAINED=OFF \
	-DENABLE_UPDATE_CHECK=OFF \
	-DENABLE_VCARD=ON \
	-DENABLE_VIDEO=ON \
	-DENABLE_VPX=ON \
	-DENABLE_WEBRTC_AEC=OFF \
	-DENABLE_WEBRTC_AECM=OFF \
	-DENABLE_X264=OFF \
	-DENABLE_ZRTP=ON

make
make sdk
make zipsdk

## copy simlar's public ssl certificate
cp "${ROOT_CA}" liblinphone-sdk/apple-darwin/share/linphone/rootca.pem

## copy sdk
rm -rf "${DEST_DIR}"
mkdir "${DEST_DIR}"
gcp -a liblinphone-sdk/apple-darwin/ "${DEST_DIR}/"
rm -rf "${DEST_DIR}/apple-darwin/share/"

echo "liblinphone build successfull with git hash: ${GIT_HASH}"
