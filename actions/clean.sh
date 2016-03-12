#!/usr/bin/env sh
#
# Sequentially execute the cleanup scripts.

set -e

actiondir="$(dirname "$0")"

# Depends: path/src/actions/fix_bugs.sh path/src/actions/strip.sh
# Depends: path/src/actions/unmount_sysroot.sh
actions="fix_bugs.sh \
    strip.sh \
    unmount_sysroot.sh"

for action in ${actions}; do
    "${actiondir}/${action}"
done

