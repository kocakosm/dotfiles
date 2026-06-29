#!/usr/bin/env bash

set -eEuo pipefail
IFS=$'\n\t'

DIR="$(cd "$(dirname "${0}")/current" || exit; pwd)"
readonly DIR

LAUNCHER="$(ls "${DIR}"/plugins/org.eclipse.equinox.launcher_*.jar)"
readonly LAUNCHER

DATA_DIR="${HOME}/.local/state/jdtls/$(pwd | cat | md5sum | cut -d ' ' -f 1)"
readonly DATA_DIR

java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.level=ALL \
    -Xmx1G \
    --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMED \
    -jar "${LAUNCHER}" \
    -configuration "${DIR}/config_linux" \
    -data "${DATA_DIR}"
