# Roadmap #

## Packages ##

Packages to be fixed:
- make (tries to use /bin/sh)
- busybox man requires nroff
- MANPATH is not set correctly for busybox?
- snownews is also broken (segfaults)
- openssl 1.1.0 breaks lynx, wpa\_supplicant, snownews builds
- flex does not cross compile

I should also run namcap on the remaining packages, and fix any warnings...

Otherwise, grep for TODO's in the PKGBUILDs.


## Misc ##

- Working on the Toshiba (v0.3.0)
- Being able to build all the Arch Linux packages (maybe?)
- Improve the documentation
- Update the Toshiba kernel config
- Shrink memory usage for the kernel and userspace

