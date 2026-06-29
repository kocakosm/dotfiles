#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if [ -z "${1+x}" ]; then
    echo "usage: ${0} <version>"
    exit 1
fi

readonly BASE_URL='https://download.eclipse.org/jdtls/milestones'

if [ ! -d "${1}" ]; then
    archive=$(curl --silent "${BASE_URL}/${1}/latest.txt")
    download_url="${BASE_URL}/${1}/${archive}"
    curl --create-dirs -L "${download_url}" -o "${1}/${archive}"
    if ! [[ $(sha256sum "${1}/${archive}" | cut -d ' ' -f 1) = $(curl --silent "${BASE_URL}/${1}/${archive}.sha256") ]]; then
        echo 'Checksum verification failed...'
        rm -Rf "${1}"
        exit 1
    fi
    (cd "${1}" && tar -xaf "${archive}" > /dev/null 2>&1 && rm -f "${archive}")
fi

if [ -h 'current' ]; then
    rm current
fi
ln -s "${1}" current
