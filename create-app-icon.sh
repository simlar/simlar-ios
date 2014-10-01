#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r  INPUT_FILE=${1:?"Please give a picture as first parameter"}
#declare -r  GIT_HASH=${2:-"unknown"}

declare -r DST_DIR="$(dirname $(readlink -f $0))/Simlar/images/app-icon"

mkdir -p "${DST_DIR}"

declare -r DIMENSIONS="29 40 50 57 58 72 76 80 100 114 120 144 152 512 1024"

for DIMENSION in ${DIMENSIONS} ; do
    convert "${INPUT_FILE}" -resize "${DIMENSION}x${DIMENSION}" "${DST_DIR}/app-icon-${DIMENSION}x${DIMENSION}.png"
done
