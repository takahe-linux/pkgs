#!/usr/bin/env sh
#
# Sequentially execute the setup scripts.

set -e

actiondir="$(dirname "$0")"

# Depends: actions/clean_sysroot.sh actions/clean_toolchain.sh
# Depends: actions/mount_sysroot.sh actions/prepare_sysroot.sh
actions="clean_sysroot.sh
    clean_toolchain.sh
    mount_sysroot.sh
    prepare_sysroot.sh"

for action in ${actions}; do
    "${actiondir}/${action}"
done
