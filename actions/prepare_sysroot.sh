#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Create a system root at ${_sysroot}

# Check that the sysroot dir does exist
if [ ! -e "${_sysroot}" ]; then
    error "Sysroot dir does not exist!"
    exit 1
fi

# Make the default directories
#TODO: Fix so that it uses the variables from config.sh
sudo mkdir -m 0755 -p "${_sysroot}"/var/{cache/pacman/pkg,lib/pacman,log} "${_sysroot}"/{dev,run,etc}
sudo mkdir -m 1777 -p "${_sysroot}"/tmp
sudo mkdir -m 0555 -p "${_sysroot}"/{sys,proc}
sudo pacman --config "$(dirname $(realpath $0))"/../pacman.conf -Sy

echo "Created sysroot at '${_sysroot}'"

