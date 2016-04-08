#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Clean the sysroot directory...

if [ -e "/sysroot" ]; then
    message "Is this the correct system root: /sysroot?"
    message "WARNING: Everything under /sysroot _will_ be deleted."
    message "Are you sure that you want to proceed? [y/N]"
    read input
    if [ "${input}" == "y" ]; then
        message "Deleting everything under '/sysroot'..."
        if mountpoint "/sysroot"; then
            sudo umount "/sysroot"
        fi
        sudo rm -r "/sysroot"
    else
        error "Aborting!"
        exit 1
    fi
else
    echo "Sysroot does not exist."
fi
