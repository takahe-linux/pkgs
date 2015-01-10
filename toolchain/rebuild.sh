#!/usr/bin/env sh

################################################################################
# Script to rebuild the toolchain, using the new vars in the config files.
#
# On one of my machines (Core 2 Duo @ 2.4GHz, 3GB RAM), the packages built in 
# about 29 minutes. YMMV
#
# Author: Alastair Hughes
# Contact: < hobbitalastair at yandex dot com >
# Date: 7-1-15
################################################################################

# Making bash exit if need be (and other shells?)
#set -e
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
packages="linux-api-headers m4 pkg-config gmp mpfr mpc binutils gcc-static libc gcc"
# sysroot specific:
#packages="echo ${packages} | sed s:gcc-static::"
# Edit this for individual packages:
# Note that order will need to be maintained...
#packages=""

remove_packages() {

    # Remove the packages, if they are installed
    for pkg in $@; do
        pacman -Q ${target_triplet}-${pkg} && yes 'y' | \
            sudo pacman -Rsc ${target_triplet}-${pkg}
    done
}

build_package() {
    pkg="$1"

    cd "${toolchain}/${pkg}"

    # Clean tmp dir, if it exists.
    builddir="/tmp/makepkg/"
    if [ -d "${builddir}" ]; then
        rm -rf "${builddir}"
    fi

    # Build!
    # yes 'y' is for installing/removing packages.
    yes 'y' | \
        makepkg -src${makepkg_flags} --config "${toolchain}/makepkg.conf"

    error="$?"

    [ "${error}" != 0 ] && echo "!!! Build failed on pkg ${pkg}!" && exit "${error}"
}

build_all() {

    remove_packages $@

    for pkg in $@; do
        echo "--> Building package ${pkg}"
        build_package "${pkg}"
    done
}

build_all "${packages}" | tee log.txt


