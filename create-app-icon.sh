#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r  INPUT_FILE=${1:?"Please give a picture as first parameter"}

declare -r DST_DIR="$(dirname $(readlink -f $0))/Simlar/images/app-icon"

mkdir -p "${DST_DIR}"

declare -r DIMENSIONS="29 40 58 76 80 87 120 152 180"

for DIMENSION in ${DIMENSIONS} ; do
    convert "${INPUT_FILE}" -resize "${DIMENSION}x${DIMENSION}" "${DST_DIR}/app-icon-${DIMENSION}x${DIMENSION}.png"
done
