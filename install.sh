#!/usr/bin/sh
# Install some packages ($@) to the sysroot

source ./config.sh

sudo pacstrap -C pacman.conf -d -G -i -M "${_sysroot}" $@
