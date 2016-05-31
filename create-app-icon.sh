#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r  INPUT_FILE=${1:?"Please give a picture as first parameter"}

declare -r DST_DIR="$(dirname $(greadlink -f $0))/Simlar/Images.xcassets/AppIcon.appiconset"

mkdir -p "${DST_DIR}"

declare -r DIMENSIONS="29 40 58 76 80 87 120 152 167 180"

for DIMENSION in ${DIMENSIONS} ; do
    convert "${INPUT_FILE}" -strip -resize "${DIMENSION}x${DIMENSION}" "${DST_DIR}/app-icon-${DIMENSION}x${DIMENSION}.png"
done

cd ${DST_DIR}
cp app-icon-58x58.png   app-icon-58x58-1.png
cp app-icon-80x80.png   app-icon-80x80-1.png
cp app-icon-120x120.png app-icon-120x120-1.png
