#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Setup the system automatically...

sudo sh -c "echo '/dev/sda1 / ext2 rw,relatime,noatime,data=ordered 0 1' > "${_sysroot}/etc/fstab""
if [ -f "${_sysroot}/etc/fstab" ]; then
    echo "Added fstab"
else
    error "Failed to add fstab!???"
    exit 1
fi

