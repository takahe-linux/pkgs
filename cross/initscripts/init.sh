#!/usr/bin/busybox hush

# Mount the expected filesystems.
mount -t proc proc /proc
mount -t sysfs sys /sys
mount -t tmpfs tmp /tmp
mount -a

# Apply the hostname.
hostname -F /etc/hostname

# Initialise the devices.
mdev -s
ln -s /proc/self/fd /dev/fd

# Run the helper script.
while true; do
    /etc/init.d/run
done
