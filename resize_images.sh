#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r SRC_DIR="$(dirname $(greadlink -f $0))/Simlar/Images.xcassets/"

function resize()
{
	local -r SRC=$1
	local -r DST=$2
	local -r SCALE=$3

	rm -f ${DST}
	convert "${SRC}" -strip -resize "${SCALE}" "${DST}"
	file "${DST}"
}

find "${SRC_DIR}" -type f -name "*@3x.png" | sort | while read IMAGE; do
	IMAGE_NAME=$(dirname "${IMAGE}")/$(basename -s @3x.png "${IMAGE}")

	resize "${IMAGE}" "${IMAGE_NAME}@1x.png" "33.33%"
	resize "${IMAGE}" "${IMAGE_NAME}@2x.png" "66.67%"
done
