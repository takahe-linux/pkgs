#!/usr/bin/busybox hush
# TODO: Research what actually needs to happen here:
#       - Sync the disk?
#       - Remount everything r/o?
#       - Kill/wait for remaining processes?

call="${0##*/}"
"${call}" -f
