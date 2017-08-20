#!/usr/bin/hush

# Mount the filesystems.
mount -t proc proc /proc
mount -t sysfs sys /sys
mount -a

# Apply the hostname.
hostname -F /etc/hostname

# Initialise the devices.
ln -s /proc/self/fd /dev/fd
mdev -s
# mdev -s doesn't poke network devices; do that here.
for i in /sys/class/net/*/uevent; do
    printf 'add' > "$i"
done 2> /dev/null

# Run the helper script.
[ -x /etc/init.d/run ] && /etc/init.d/run
