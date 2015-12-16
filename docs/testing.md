# Tests #

I intend to implement some kind of automatic sanity test system, just to give
me some extra peace of mind when I update things.

Some of these tests would be better integrated into makepkg, somehow.

I'd also like to implement automatic testing of the configureables, ie
target architecture; however, that is less important at the moment.

## Stage 1 (toolchain) ##

- Files end up in sane locations
- Toolchain works ('hello world' works with qemu-$ARCH)

## Stage 2 (statically linked build system) ##

- Everything is statically linked
- Nothing is packaged into /lib, /bin, ...
- All executables are of the correct architecture
- System is bootable
- All symlinks point to something relevant (inside the sysroot)
- Check that some directories don't exist (share/info)

### busybox ###

- All symlinks are valid (busybox actually lists that symlink)
- All applets are symlinked
- Sanity checks

### pacman ###

- All installed packages are listed
- makepkg works (test 'hello world' PKGBUILD?)

### toolchain ###

- binutils works (?)
- gcc works

