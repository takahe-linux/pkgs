#!/usr/bin/env sh
#
# Sequentially execute the cleanup scripts.

set -e

actiondir="$(dirname "$0")"

actions="fix_bugs.sh \
    strip.sh \
    unmount_sysroot.sh"

for action in ${actions}; do
    "${actiondir}/${action}"
done

