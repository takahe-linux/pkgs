#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Clean the sysroot directory...

_sysroot="${_sysroot}"

if [ "z${_sysroot}" != "z/" ] && [ "z${_sysroot}" != "z" ]; then
    if [ -e "${_sysroot}" ]; then
        message "Is this the correct system root: ${_sysroot}?"
        message "WARNING: Everything under ${_sysroot} _will_ be deleted."
        message "Are you sure that you want to proceed? [y/N]"
        read input
        if [ "${input}" == "y" ]; then
            message "Deleting everything under '${_sysroot}'..."
            if mountpoint "${_sysroot}"; then
                sudo umount "${_sysroot}"
            fi
            sudo rm -r "${_sysroot}"
        else
            error "Aborting!"
            exit 1
        fi
    else
        echo "Sysroot does not exist."
    fi
else
    error "Sysroot '${_sysroot}' is not valid!"
    exit 1
fi
