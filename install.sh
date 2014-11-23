#!/usr/bin/sh
# Install some packages ($@) to 'sysroot'

sudo pacstrap -C pacman.conf -d -G -i -M sysroot $@
