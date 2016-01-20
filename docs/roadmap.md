# Roadmap #

## Packages ##

Packages to do:
- curl + ca-certs + git (for bootstrapping)?
- kernel + bootloader (v0.2.0)
- fakefakeroot
- tests

Packages to be updated:
- kernel
- others?

Packages to be fixed:
- make (tries to use /bin/sh)
- epoch's config is currently broken
- All packages using ${_licensedir} currently use /usr/share/license; they
  should use /usr/share/licenses. This needs to be changed during the next full
  rebuild (ie GCC version bump).
- /dev/fd -> /proc/self/fd symlink is not created - this needs to be
  dynamically created, so probably in the mdev or epoch config.
- The build system's fix_bugs.sh script should be renamed.

Note that file is currently broken (segfaults after running), but that is
fixed in git (checked 142c984) so should be fixed in the next release.
I'm not packaging file as a git snapshot because file currently needs
file-git on the host to cross compile (seems to, anyway).


## Build system ##

- Fix packages in a target changing not forcing a rebuild for everything
  depending on that target (v0.1.5)
- Add better cleanup/teardown support, eg install/remove targets (v0.1.5)
- Fix relying on ordered dependencies (v0.1.5)
- Fix relying on date and time (v0.1.5)
- Add a nice way of running cleanup scripts (v0.1.5)
- Add chroot support (v0.1.5)
- Add 'strict' dependencies (via chroot?) (v0.1.5)
- Add better recurisive dependencies (ie build and run deps) (v0.1.5)
- Fix 'SATISFIED' hack (v0.1.5)
- Fix changes to the config not forcing a rebuild (v0.1.5)
- Remove remaining TODO's (v0.1.6)
- Add signal handling (v0.1.6)
- Add logging (v0.1.6)
- Add support for "farming out" build tasks to other machines on a network,
  via the clean chroot support (v0.2.0)
- Add rebuild support back in (v0.2.0)
- Add an activity monitor (v0.2.0)
- Add target (toshiba, qemu-mips, etc) support (v0.2.0)
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

