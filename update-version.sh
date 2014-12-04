#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r GIT_RELEASE_VERSION=$(git describe --tags --always --dirty)

defaults write "${BUILT_PRODUCTS_DIR}/${INFOPLIST_PATH}" "CFBundleShortVersionString" "${GIT_RELEASE_VERSION}"
defaults write "${BUILT_PRODUCTS_DIR}/${INFOPLIST_PATH}" "CFBundleVersion" "${GIT_RELEASE_VERSION}"

### ATTENTION: this assumes the version is the 3rd property
/usr/libexec/PlistBuddy -c "Set :PreferenceSpecifiers:2:DefaultValue ${GIT_RELEASE_VERSION}" "${BUILT_PRODUCTS_DIR}/Simlar.app/Settings.bundle/Root.plist"
