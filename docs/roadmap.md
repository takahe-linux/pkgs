# Roadmap #

## Packages ##

Packages to be fixed:
- make (tries to use /bin/sh)
- epoch's config is currently broken
- /dev/fd -> /proc/self/fd symlink is not created - this needs to be
  dynamically created, so probably in the mdev or epoch config
- busybox does not get installed suid
- busybox man requires nroff
- MANPATH is not set correctly for busybox?

I should also run namcap on the remaining packages, and fix any warnings...

Currently, curl complains because the -I and -L CFLAGS are not in CPPFLAGS
and LDFLAGS, respectively. I could fix that, but I'll save it for the next big
rebuild.


## Misc ##

- Working on the Toshiba (v0.3.0)
- Being able to build all the Arch Linux packages (maybe?)
- Improve the documentation.
- Update the Toshiba kernel config.
- Shrink memory usage for the kernel and userspace.


## Testing system ##

See docs/testing.md.

