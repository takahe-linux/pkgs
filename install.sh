#!/usr/bin/sh
# Install some packages ($@) to the sysroot

SYSROOT="$(cat makepkg.conf | grep '_sysroot=' | cut -f2 -d=)"

sudo pacstrap -C pacman.conf -d -G -i -M "${SYSROOT}" $@
