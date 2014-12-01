#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r GIT_RELEASE_VERSION=$(git describe --tags --always --dirty)

defaults write "${BUILT_PRODUCTS_DIR}/${INFOPLIST_PATH}" "CFBundleShortVersionString" "${GIT_RELEASE_VERSION}"
defaults write "${BUILT_PRODUCTS_DIR}/${INFOPLIST_PATH}" "CFBundleVersion" "${GIT_RELEASE_VERSION}"
