#!/usr/bin/env bash
set -xeo pipefail

TOOLCHAIN_DIR=/opt/rh/devtoolset-8/root/usr/bin
if [[ -d "$TOOLCHAIN_DIR" ]]; then
    PATH="$TOOLCHAIN_DIR:$PATH"
fi

PROJECT_DIR=$(dirname "$0")
GETDEPS_PATHS=(
    "$PROJECT_DIR/build/fbcode_builder/getdeps.py"
    "$PROJECT_DIR/../../opensource/fbcode_builder/getdeps.py"
)

ROOT_DIR=$(pwd)
STAGE=${ROOT_DIR}/_build/
mkdir -p "$STAGE"

for getdeps in "${GETDEPS_PATHS[@]}"; do
    if [[ -x "$getdeps" ]]; then
        "$getdeps" build katran --current-project katran "$@"
        exit 0
    fi
done

echo "Could not find getdeps.py!?" >&2
exit 1
