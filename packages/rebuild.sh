#!/usr/bin/env sh

################################################################################
# Script to rebuild the base system (in order).
#
# This is mostly a sanity check, however it should also help spot when a change
# to one package affects another...
#
# Author: Alastair Hughes
# Contact: < hobbitalastair at yandex dot com >
# Date: 7-1-15
################################################################################

# Config...
#TODO: Set some of this automatically...
#TODO: Accept CLI arguments.
takahe_root="/home/ash/distro/takahe-linux"
pacman_conf="${takahe_root}/pacman.conf"

# Set the builddir
builddir="/tmp/makepkg/"
# Set the pacman repo.
pkgrepo="${takahe_root}/pkgs/custom.db.tar.xz"

# Set this to "f" to force rebuilding, for example.
#makepkg_flags=""
# Rebuild everything
makepkg_flags="f"

# Edit this to change the which packages are built, and the order.
# Default:
packages="gmp mpfr zlib ncurses bash busybox linux e2fsprogs"
# Edit this for individual packages:
# Note that order will need to be maintained...
#packages=""

remove_packages() {

    # Remove the packages, if they are installed
    for pkg in $@; do
        pacman --config "${pacman_conf}" -Q "${pkg}" && yes 'y' | \
            sudo pacman --config "${pacman_conf}" -Rc "${pkg}"
    done
}

build_package() {
    pkg="$1"

    cd "${takahe_root}/core/${pkg}"

    # Clean tmp dir, if it exists.
    if [ -d "${builddir}" ]; then
        rm -rf "${builddir}"
    fi

    # Build!
    # yes 'y' is for installing/removing packages.
    # I cannot figure out how to remove to 'd' flag - makepkg will not accept
    # an alternative value for pacman's conf... and aliasing does not work.
    yes 'y' | \
        makepkg -srdcL${makepkg_flags} --config "${takahe_root}/makepkg.conf"

    error="$?"

    [ "${error}" != 0 ] && echo "!!! Build failed on pkg ${pkg}!" && \
        exit "${error}"

    # Built... add the package to the repo
    repo-add "${pkgrepo}" ${pkg}-*.pkg.tar.*

    # Update pacman and install the new pkg.
    yes 'y' | sudo pacman --config "${pacman_conf}" -Udd ${pkg}-*.pkg.tar.*
}

build_all() {

    remove_packages $@

    for pkg in $@; do
        echo "--> Building package ${pkg}"
        build_package "${pkg}"
        echo "--> Built package ${pkg}"
    done
}

build_all "${packages}"

