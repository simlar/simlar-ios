#!/bin/bash

## exit if an error occurs or on unset variables
set -eu -o pipefail

declare -r USAGE="Usage example: $0 1 0 0 [master]"

declare -ri VERSION_MAJOR=${1?${USAGE}}
declare -ri VERSION_MINOR=${2?${USAGE}}
declare -ri VERSION_BUGFIX=${3?${USAGE}}
declare -r  BRANCH=${4:-"master"}

declare -r SIMLAR_VERSION="${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_BUGFIX}"
echo "creating tag: '${SIMLAR_VERSION}'"

if ! git diff --quiet ; then
        git status
        echo "git is dirty => aborting"
        exit 1
fi

git checkout "${BRANCH}"
git fetch
git fetch --tags
git pull --rebase origin "${BRANCH}"


git tag -s "${SIMLAR_VERSION}" -m "Version: ${SIMLAR_VERSION}"
git push origin "${SIMLAR_VERSION}"
git checkout "${SIMLAR_VERSION}"
