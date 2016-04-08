#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Setup the system automatically...

sudo sh -c "echo '/dev/sda1 / ext2 rw,relatime,noatime,data=ordered 0 1' > '/sysroot/etc/fstab'"
if [ -f "/sysroot/etc/fstab" ]; then
    echo "Added fstab"
else
    error "Failed to add fstab!???"
    exit 1
fi

# Add the gen_broken script
# TODO: Remove
sudo install -m0755 "$(dirname "$(realpath "$0")")/../test/gen_broken" "/sysroot/usr/bin"

