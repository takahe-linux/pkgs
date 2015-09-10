# Roadmap #

## v0.1.3 ##

- Fix bash build so it uses the system readline (libedit).
- Add file + zlib + gettext packages.

## v0.1.4 ##

- Add make + binutils + gcc packages.

## v0.1.5 ##

- Transfer to a rootless, chrooted build.
- Add an 'activity' bar/monitor.
- Add signal handling to the build system.

## v0.2.0 ##

- Standalone system!
- Kernel and bootloader built and installed.
- Improved build system.

## v0.3.0 ##

- Working on the Toshiba.

## Misc ##

- Update the toolchain packages.
- Update the linux kernel build.
- Add a target for my Toshiba.
- Make the build system handle different targets cleanly.
- Improve the documentation.
- Update the Toshiba kernel config.
- Shrink memory usage for the kernel and userspace.
- Iterate towards a dependency-based rebuild script:
  - Add support for removing uneeded packages.
  - Add support for asynchronous builds.
- Add a customised makepkg script that also handles a better selection of
  dependencies.
- Add tests!
- Add a third stage; the 'final' stage, meant to be built on the target or in
  an emulator.

