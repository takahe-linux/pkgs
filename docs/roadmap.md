# Roadmap #

## Issues ##

Packages to be fixed:
- openssl 1.1.0 breaks lynx, wpa\_supplicant, snownews builds
- flex does not cross compile (see issue #78)
- netsurf has some relatively easy fixes
- the toolchain pkg-config seems to be broken - figure out what uses it and
  make it an explicit dependency, fixing it if at all possible
- e2fsprogs should be part of base? (for e2fsck)

I should also run namcap on the remaining packages, and fix any warnings...

Otherwise, grep for TODO's in the PKGBUILDs.


## Packages ##

Remaining packages:

- alsa-utils

Packages to consider adding:

- nldev
- micropython
- pass
- x11 and related (dwm, st, dmenu, xorg utils, xclip, ...)?
- daemon manager + associated scripts?
- mpv?


## Misc ##

- All remaining packages built (v0.3.2)
- Mirror set up (v0.4.0)
- Website published (v0.4.0)
- Being able to build all the Arch Linux packages (maybe?)
- Shrink memory usage for the kernel and userspace

