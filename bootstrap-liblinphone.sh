#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r BRANCH=${1:-"4.4.24"} ## use master to build current git revision

declare -r PROJECT_DIR="$(dirname $(greadlink -f $0))"

declare -r COMPILE_SCRIPT="${PROJECT_DIR}/compile-liblinphone.sh"
declare -r LINPHONE_IOS_PATCH_DIR="${PROJECT_DIR}/patches/linphone-ios"
declare -r LINPHONE_PATCH_DIR="${PROJECT_DIR}/patches/linphone"
declare -r MEDIASTREAMER2_PATCH_DIR="${PROJECT_DIR})/patches/mediastreamer2"
declare -r BELLESIP_PATCH_DIR="${PROJECT_DIR}/patches/belle-sip"
declare -r ORTP_PATCH_DIR="${PROJECT_DIR}/patches/ortp"
declare -r BZRTP_PATCH_DIR="${PROJECT_DIR}/patches/bzrtp"

declare -r BUILD_DIR="${PROJECT_DIR}/liblinphone_build_$(basename "${BRANCH}")_$(date '+%Y%m%d_%H%M%S')"
mkdir "${BUILD_DIR}"
cd "${BUILD_DIR}"

git clone https://gitlab.linphone.org/BC/public/linphone-sdk.git
cd linphone-sdk
git checkout "${BRANCH}"

declare -r GIT_HASH=$(git log -n1 --format="%H")

if [ -d "${LINPHONE_IOS_PATCH_DIR}" ] ; then
	git am "${LINPHONE_IOS_PATCH_DIR}"/*.patch
fi

git submodule sync
git submodule update --recursive --init

if [ -d "${LINPHONE_PATCH_DIR}" ] ; then
	cd linphone/
	git am "${LINPHONE_PATCH_DIR}"/*.patch
	cd ../..
fi

if [ -d "${MEDIASTREAMER2_PATCH_DIR}" ] ; then
	cd mediastreamer2
	git am "${MEDIASTREAMER2_PATCH_DIR}"/*.patch
	cd ../../..
fi

if [ -d "${BZRTP_PATCH_DIR}" ] ; then
	cd bzrtp/
	git am "${BZRTP_PATCH_DIR}"/*.patch
	cd ../..
fi


cd ../..

"${COMPILE_SCRIPT}" "${BUILD_DIR}" "${GIT_HASH}"
