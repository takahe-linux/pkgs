# Roadmap #

## v0.1.3 ##

- Transfer to a rootless, chrooted build.
- Add signal handling to the build system.
- Add file + diffutils + patch packages.

## Misc ##

- Add a target for my Toshiba.
- Make the build system handle different targets cleanly.
- Add extra packages (GCC!).
- Improve the documentation.
- Update the Toshiba kernel config.
- Shrink memory usage for the kernel and userspace.
- Iterate towards a dependency-based rebuild script:
  - Add support for removing uneeded packages.
  - Add support for asynchronous builds.
  - Add 'dirty' options for specific dependencies/packages.
- Add a customised makepkg script that also handles a better selection of
  dependencies.
- Add tests!
- Add a third stage; the 'final' stage, meant to be built on the target or in
  an emulator.

