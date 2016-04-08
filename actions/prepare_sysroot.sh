#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Create a system root at /sysroot

# Check that the sysroot dir does exist
if [ ! -e "/sysroot" ]; then
    error "Sysroot dir does not exist!"
    exit 1
fi

# Make the default directories
#TODO: Fix so that it uses the variables from config.sh
sudo mkdir -m 0755 -p "/sysroot"/var/{cache/pacman/pkg,lib/pacman,log} "/sysroot/"{dev,run,etc}
sudo mkdir -m 1777 -p "/sysroot"/tmp
sudo mkdir -m 0555 -p "/sysroot"/{sys,proc}
sudo pacman --config "$(dirname $(realpath $0))"/../pacman.conf -Sy

echo "Created sysroot at '/sysroot'"

