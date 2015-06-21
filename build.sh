#!/usr/bin/env sh
#
# Build script for Takahe Linux.
#
# Author:   Alastair Hughes
# Date:     17-6-2015
# Contact:  < hobbitalastair at yandex dot com >

set -e

#
# Define build variables
#

rootdir="$(dirname $(realpath $0))"

toolchain="packages/linux-api-headers \
    toolchain/binutils \
    toolchain/gcc-static \
    packages/musl \
    toolchain/gcc"
base="packages/libarchive \
    packages/busybox \
    packages/filesystem \
    packages/bash \
    packages/pacman \
    packages/epoch"
cleanup="actions/fix_bugs.sh \
    actions/strip.sh \
    actions/unmount_sysroot.sh"

all="actions/setup.sh ${toolchain} ${base} ${cleanup}"

# This is for testing purposes. It will cause the program to print out what it
# would build instead of actually doing it...
noop="false"

#
# Define the helper functions
#

message() {
    echo ">>> $@"
}

check_arg_numbers() {
    # Check that there are the given numbers of arguments

    if [ "$#" -lt 1 ]; then
        message "check_arg_numbers requires an argument!"
        exit 1
    fi

    if [ "$(expr "$#" - 1)" != "$1" ]; then
        message "Expected $1 arguments; got '$#' ($@)"
        exit 1
    fi
}


#
# Define the build functions
#

build() {
    
    package="$1"

    check_arg_numbers 1 $@

    name="$(echo "${package}" | sed -e 's:.*/::')"
    prefix="$(echo "${package}" | sed -e "s:/${name}$::")"

    case "${prefix}" in
        packages) build_target "${name}" "${prefix}";;
        toolchain) build_local "${name}" "${prefix}";;
        actions) $noop || "${rootdir}/${package}";;
        *) message "Unknown package prefix '${prefix}'!";;
    esac
}

build_local() {
    # Build a given package for the local machine.

    check_arg_numbers 2 $@

    message "Building toolchain package ${prefix}/${name}..."

    cd "${rootdir}/${prefix}/${name}"

    # Figure out the names of the resulting packages.
    names="$("${rootdir}/scripts/pkgnames" "PKGBUILD")"

    # Rebuild if need be.
    if need_rebuild ${names}; then
        message "Rebuilding ${prefix}/${name}!"

        # Build the package
        "${noop}" || yes 'y' | makepkg --config ../makepkg.conf -srcfC
    fi

    # Exit as needed.
    "${noop}" && return 0

    # Install all of the resulting packages.
    for pkgname in ${names}; do
        if [ ! -e "${pkgname}" ]; then
            message "Expected to find a package in '$(pwd)' called '${pkgname}'!"
            exit 1
        fi
        yes 'y' | sudo pacman -U "${pkgname}" > /dev/null
    done
}

build_target() {
    # Build a given package for the target machine.

    check_arg_numbers 2 $@

    message "Building target package ${prefix}/${name}"


    cd "${rootdir}/${prefix}/${name}"

    # Figure out the names of the resulting packages.
    names="$("${rootdir}/scripts/pkgnames" "PKGBUILD")"

    # Rebuild if need be.
    if need_rebuild "${names}"; then
        message "Rebuilding ${prefix}/${name}!"

        # Build the package
        "${noop}" || makepkg --config ../makepkg.conf -dfCcL --nocheck
    fi

    # Exit as needed.
    "${noop}" && return 0

    # Install all of the resulting packages.
    for pkgname in ${names}; do
        if [ ! -e "${pkgname}" ]; then
            message "Expected to find a package in '$(pwd)' called '${pkgname}'!"
            exit 1
        fi
        sudo pacman --config "${rootdir}/pacman.conf" -U "${pkgname}" --noconfirm \
            > /dev/null
    done
}

need_rebuild() {
    # Check if a the package in the current directory needs to be rebuilt.
    # It assumes that a list of packages (files) are given as the arguments.
    # It will return 0 (true) if the packages need rebuilding, 1 (false) if
    # they don't.

    # Check if the build is already 'dirty'.
    if [ "$(cat "${STATUS_FILE}" | grep 'DIRTY' | sed 's:DIRTY=::')" == 'true' ]; then
        return 0
    fi

    # Check for a cached version.
    local pkgage="$(stat -c "%Y" PKGBUILD)"
    for pkgname in ${1}; do
        # Check that a symlink exists, and that the symlink is newer than the
        # pkgbuild.
        if [ ! -e "${pkgname}" ] || [ "$(stat -c "%Y" "${pkgname}")" -lt "${pkgage}" ]; then
            make_dirty
            return 0
        fi
    done

    return 1
}

make_dirty() {
    # Identify the build as being 'dirty' from this point onwards.

    echo "DIRTY=true" >> "${STATUS_FILE}"
}

#TODO: Add argument parsing for more functionality
# Possible arguments:
# --rebuild-all
# --rebuild=<packages> # Just 'touch' the PKGBUILD's?
# --???

# Create a shared status file.
STATUS_FILE="$(mktemp --suffix="-$(basename "${0}")")"

# Setup sudo_keepalive
#TODO: Remove this... building using root _is_ dangerous!
sudo echo "Sudo working, thanks!"
"${rootdir}/scripts/keepalive" "$$" "240" sudo true &
KEEPALIVE_PID="$!"

for package in ${all}; do
    build "${package}"
done

# Clean up the helper processes
kill "${KEEPALIVE_PID}"
wait

# Remove the status file.
rm "${STATUS_FILE}"

message "Cleaned up and exited!"
