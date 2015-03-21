#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Clean the sysroot directory...

_sysroot="${_sysroot}"

if [ "z${_sysroot}" != "z/" ] && [ "z${_sysroot}" != "z" ]; then
    if [ -e "${_sysroot}" ]; then
        echo "Is this the correct system root: ${_sysroot}?"
        echo "WARNING: Everything under ${_sysroot} _will_ be deleted."
        echo "Are you sure that you want to proceed? [y/N]"
        read input
        if [ "${input}" == "y" ]; then
            echo "Deleting everything under '${_sysroot}'..."
            if mountpoint "${_sysroot}"; then
                sudo umount "${_sysroot}"
            fi
            sudo rm -r "${_sysroot}"
        else
            echo "Aborting!"
            exit 1
        fi
    else
        echo "Sysroot does not exist... leaving"
    fi
else
    echo "Sysroot '${_sysroot}' is not valid!"
    exit 1
fi
