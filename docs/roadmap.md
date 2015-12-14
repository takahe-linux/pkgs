# Roadmap #

## Packages ##

Packages to do:
- curl + ca-certs + git (for bootstrapping)?
- kernel + bootloader (v0.2.0)

Packages to be updated:
- kernel
- toolchain (Arch is using gcc 5.3.0)
- others?

Packages to be fixed:
- file (currently segfaults after running)
- make (tries to use /bin/sh)
- epoch's config is currently broken


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
- Add rebuild support back in (v0.2.0)
- Add an activity monitor (v0.2.0)
- Add target (toshiba, qemu-mips, etc) support (v0.2.0)
- Add asynchronous build support (v0.3.0)
- Cross compile support in makepkg (v0.3.0)
- Add support for "farming out" build tasks to other machines on a network,
  via the clean chroot support (v0.3.0)


## Misc ##

- Standalone system, ie 3-stage bootstrap
- Working on the Toshiba (v0.3.0)
- Being able to build all the Arch Linux packages (maybe?)
- Improve the documentation.
- Update the Toshiba kernel config.
- Shrink memory usage for the kernel and userspace.

## Testing system ##

- Add some tests...
- Test for borked symlinks, missing symlinks...
- Basic sanity tests for various programs (eg pacman, ...)
- Check that some directories don't exist (ie share/info) - this might be better
  somehow integrated with makepkg (libmakepkg?).

