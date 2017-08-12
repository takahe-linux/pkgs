#!/usr/bin/hush

# Stop all the running services.
bh-stopall

# Ask everything else to terminate.
trap "" TERM
kill -TERM -1

# Remount everything readonly.
mount -a -r

# Actually shutdown/halt.
"${0##*/}" -f
