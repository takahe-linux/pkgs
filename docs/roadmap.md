# Roadmap #

## Issues ##

Packages to be fixed:
- openssl 1.1.0 breaks lynx, wpa\_supplicant, snownews builds
- netsurf has some relatively easy fixes
- the toolchain pkg-config seems to be broken - figure out what uses it and
  make it an explicit dependency, fixing it if at all possible
- e2fsprogs should be part of base? (for e2fsck)
- binutils 2.28 needs a patch or it won't build the toolchain gcc on mips

I should also run namcap on the remaining packages, and fix any warnings...

We don't consistently use groups - either conform to Arch's set of groups, or
don't bother using them (we currently use meta-packages instead).

Otherwise, grep for TODO's in the PKGBUILDs.


## Packages ##

Packages to consider adding:

- nldev
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

