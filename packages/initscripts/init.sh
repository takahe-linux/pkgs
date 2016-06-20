#!/usr/bin/sh

# Mount the expected filesystems.
mount -t proc proc /proc
mount -t sysfs sys /sys
mount -a

# Apply the hostname.
hostname -F /etc/hostname

# Initialise the devices.
# TODO: Actually use mdev...
ln -s /proc/self/fd /dev/fd

# Run the helper script.
while true; do
    /etc/init/run
done
