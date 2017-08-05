# Roadmap #

## Issues ##

Packages to be fixed:
- openssl 1.1.0 breaks lynx, wpa\_supplicant, snownews builds
- netsurf has some relatively easy fixes
- the toolchain pkg-config seems to be broken - figure out what uses it and
  make it an explicit dependency, fixing it if at all possible
- e2fsprogs should be part of base? (for e2fsck)
- musl does not require linux-api-headers to be installed to build

I should also run namcap on the remaining packages, and fix any warnings...

We don't consistently use groups - either conform to Arch's set of groups, or
don't bother using them (we currently use meta-packages instead).

If I decide to stick with static linking, I should split the static packages
into lib and bin subpackages, with the lib packages depending on the other
packages which are actually required for linking with it.

Some of the packages in cross/ should be moved into native, eg e2fsprogs...

Otherwise, grep for TODO's in the PKGBUILDs.


## Packages ##

Packages to consider adding:

- nldev
- pass
- x11 and related (dwm, st, dmenu, xorg utils, xclip, ...)?
- daemon manager + associated scripts?


## Misc ##

- All remaining packages built (v0.3.2)
- Mirror set up (v0.4.0)
- Website published (v0.4.0)
- Being able to build all the Arch Linux packages (maybe?)
- Shrink memory usage for the kernel and userspace

