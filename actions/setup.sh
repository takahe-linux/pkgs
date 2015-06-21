#!/usr/bin/env sh
#
# Sequentially execute the setup scripts.

set -e

actiondir="$(dirname "$0")"

actions="clean_sysroot.sh
    clean_toolchain.sh
    mount_sysroot.sh
    prepare_sysroot.sh"

for action in ${actions}; do
    "${actiondir}/${action}"
done
