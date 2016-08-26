# Roadmap #

## Packages ##

Packages to be fixed:
- make (tries to use /bin/sh)
- sinit does not come with any init scripts (probably create a new package with
  some instead of adding them to sinit; rename sinit binary to init?)
- /dev/fd -> /proc/self/fd symlink is not created - this needs to be
  dynamically created, so probably in the mdev or sinit config
- busybox does not get installed suid (due to fakeroot usage)
- busybox man requires nroff
- MANPATH is not set correctly for busybox?
- toolchain/gcc runs strip on some files of the wrong arch
- ncurses built for i586 does not properly install the terminfo database
- gdb is currently broken (builds a dynamic binary)
- snownews is also broken (segfaults)
- openssl 1.1.0 breaks lynx, wpa\_supplicant, snownews builds

I should also run namcap on the remaining packages, and fix any warnings...

Otherwise, grep for TODO's in the PKGBUILDs.


## Misc ##

- Working on the Toshiba (v0.3.0)
- Being able to build all the Arch Linux packages (maybe?)
- Improve the documentation
- Update the Toshiba kernel config
- Shrink memory usage for the kernel and userspace

