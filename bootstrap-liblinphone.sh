#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r BRANCH=${1:-"5.3.5"} ## use master to build current git revision

declare -r PROJECT_DIR="$(dirname $(greadlink -f $0))"

declare -r COMPILE_SCRIPT="${PROJECT_DIR}/compile-liblinphone.sh"
declare -r LINPHONE_SDK_PATCH_DIR="${PROJECT_DIR}/patches/linphone-sdk"
declare -r LIBLINPHONE_PATCH_DIR="${PROJECT_DIR}/patches/liblinphone"
declare -r MEDIASTREAMER2_PATCH_DIR="${PROJECT_DIR}/patches/mediastreamer2"
declare -r BELLESIP_PATCH_DIR="${PROJECT_DIR}/patches/belle-sip"
declare -r ORTP_PATCH_DIR="${PROJECT_DIR}/patches/ortp"
declare -r BZRTP_PATCH_DIR="${PROJECT_DIR}/patches/bzrtp"
declare -r LIBOQS_PATCH_DIR="${PROJECT_DIR}/patches/liboqs"

declare -r BUILD_DIR="${PROJECT_DIR}/liblinphone_build_$(basename "${BRANCH}")_$(date '+%Y%m%d_%H%M%S')"
mkdir "${BUILD_DIR}"
cd "${BUILD_DIR}"

git clone https://gitlab.linphone.org/BC/public/linphone-sdk.git
cd linphone-sdk
git checkout "${BRANCH}"

declare -r GIT_HASH=$(git log -n1 --format="%H")

if [ -d "${LINPHONE_SDK_PATCH_DIR}" ] ; then
	git am "${LINPHONE_SDK_PATCH_DIR}"/*.patch
fi

git submodule sync
git submodule update --recursive --init

if [ -d "${LIBLINPHONE_PATCH_DIR}" ] ; then
	pushd liblinphone/
	git am "${LIBLINPHONE_PATCH_DIR}"/*.patch
	popd
fi

if [ -d "${MEDIASTREAMER2_PATCH_DIR}" ] ; then
	pushd mediastreamer2
	git am "${MEDIASTREAMER2_PATCH_DIR}"/*.patch
	popd
fi

if [ -d "${BZRTP_PATCH_DIR}" ] ; then
	pushd bzrtp/
	git am "${BZRTP_PATCH_DIR}"/*.patch
	popd
fi

if [ -d "${LIBOQS_PATCH_DIR}" ] ; then
	pushd external/liboqs
	git am "${LIBOQS_PATCH_DIR}"/*.patch
	popd
fi

cd ../..

"${COMPILE_SCRIPT}" "${BUILD_DIR}" "${GIT_HASH}"
