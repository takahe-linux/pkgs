#!/usr/bin/env sh

################################################################################
# Script to rebuild the toolchain, using the new vars in the config files.
#
# Author: Alastair Hughes
# Contact: < hobbitalastair at yandex dot com >
# Date: 7-1-15
################################################################################

# Making bash exit if need be (and other shells?)
set -e
#set -o pipefail

# Config...
#TODO: Set some of this automatically...
#TODO: Accept CLI arguments.
takahe_root="/home/ash/distro/takahe-linux"
toolchain="${takahe_root}/toolchain"
#TODO: Make this automatic.
target_triplet='i586-linux-musl'

# Set this to "f" to force rebuilding, for example.
#makepkg_flags=""
# Rebuild and install everything
makepkg_flags="fi"

# Edit this to change the which packages are built, and the order.
# Default:
packages="linux-api-headers binutils gcc-static musl gcc"
# sysroot specific:
#packages="linux-api-headers gcc-static musl gcc"

# Remove the packages, if they are installed
for pkg in ${packages}; do
    pacman -Q ${target_triplet}-${pkg} && yes 'y' | sudo pacman -R ${target_triplet}-${pkg}
done

for pkg in ${packages}; do
    cd "${toolchain}/${pkg}"

    # Clean tmp dir, if it exists.
    #TODO: Improve to use the target triplet (from where?)
    builddir="/tmp/makepkg/${target_triplet}-${pkg}"
    if [ -d "${builddir}" ]; then
        rm -rf "${builddir}"
    fi

    # Build!
    # yes 'y' is for installing/removing packages.
    yes 'y' | \
        makepkg -src${makepkg_flags} --config "${toolchain}/makepkg.conf" | \
        tee log.txt

done
