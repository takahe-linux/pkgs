#!/usr/bin/hush

# Stop all the running services.
bh-stopall

# Kill everything else.
killall5 -SIGKILL

# Remount everything readonly.
umount -a -r
mount -o remount,ro /dev/root /

# Actually shutdown/halt.
"${0##*/}" -f
