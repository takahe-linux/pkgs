#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Unmount the sysroot, unset the loop device, and print a message noting
# which one is the final device.


loopdev="$(mount | grep -e "/dev/loop.* on /sysroot " | cut -d' ' -f'1')"

if [ "z${loopdev}" == "z" ]; then
    error "Cannot find a loopdevice mounted on /sysroot!"
    exit 1
fi

# Unmount the loop device
sudo umount "${loopdev}"
echo "Unmounted ${loopdev}"

# Kill the sysroot dir
sudo rmdir "/sysroot"

# Remove the loopdev
sudo losetup -d "$(echo ${loopdev} | sed -e 's:p1$::')"
echo "Cleaned up loopdev $(echo ${loopdev} | sed -e 's:p1$::')"


