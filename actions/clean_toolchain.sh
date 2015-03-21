#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Clean out the installed toolchain packages...

# In theory, all of the packages should belong to the group...
echo "Removing all toolchain packages..."
sudo pacman -R ${_target_triplet} --noconfirm --noprogressbar ||
    echo "The toolchain appears to not be installed"

