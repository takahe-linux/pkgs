# Roadmap #

## Packages ##

Packages to do:
- ca-certs + git (for bootstrapping)?
- kernel + bootloader (v0.2.0)
- tests

Packages to be updated:
- kernel
- others?

Packages to be fixed:
- make (tries to use /bin/sh)
- epoch's config is currently broken
- /dev/fd -> /proc/self/fd symlink is not created - this needs to be
  dynamically created, so probably in the mdev or epoch config.

I should also run namcap on the remaining packages, and fix any warnings...


## Build system ##

- Check for updates script support (v0.1.5)
- Remove remaining TODO's (v0.1.6)
- Add signal handling (v0.1.6)
- Add support for "farming out" build tasks to other machines on a network,
  via the clean chroot support (v0.2.0)
- Add rebuild support back in (v0.2.0)
- Add an activity monitor (v0.2.0)
- Add asynchronous build support (v0.3.0)
- Cross compile support in makepkg (v0.3.0)


## Misc ##

- Standalone system, ie 3-stage bootstrap
- Working on the Toshiba (v0.3.0)
- Being able to build all the Arch Linux packages (maybe?)
- Improve the documentation.
- Update the Toshiba kernel config.
- Shrink memory usage for the kernel and userspace.


## Testing system ##

See docs/testing.md.

