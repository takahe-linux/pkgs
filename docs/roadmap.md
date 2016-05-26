# Roadmap #

## Packages ##

Packages to be fixed:
- make (tries to use /bin/sh)
- epoch's config is currently broken
- /dev/fd -> /proc/self/fd symlink is not created - this needs to be
  dynamically created, so probably in the mdev or epoch config.

I should also run namcap on the remaining packages, and fix any warnings...


## Misc ##

- Standalone system, ie 3-stage bootstrap
- Working on the Toshiba (v0.3.0)
- Being able to build all the Arch Linux packages (maybe?)
- Improve the documentation.
- Update the Toshiba kernel config.
- Shrink memory usage for the kernel and userspace.


## Testing system ##

See docs/testing.md.

