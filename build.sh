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
# Define the helper build functions
#

build_package() {
    # Build a given package with the given arguments for makepkg and pacman.
    # Usage: build_package <name> <prefix>
    # Influential variables: $pacman_args, $makepkg_args

    check_arg_numbers 2 $@

    name="$1"
    prefix="$2"

    case "${prefix}" in
        toolchain) target="local";;
        packages) target="target";;
        *) echo "Unknown target '${prefix}'!"; exit 1;;
    esac

    message "Building ${target} package ${prefix}/${name}..."

    cd "${rootdir}/${prefix}/${name}"

    # Figure out the names of the resulting packages.
    names="$("${rootdir}/scripts/pkgnames" "PKGBUILD")"

    # Rebuild if need be.
    if need_rebuild ${names}; then
        message "Rebuilding ${prefix}/${name}!"

        # Build the package
        "${noop}" || yes 'y' | makepkg --config ../makepkg.conf -cC \
            ${makepkg_args}
    fi

    # Install all of the resulting packages.
    # Also, keep track of the oldest package; this is used elsewhere in the
    # script, and will be until I get proper dependencies. 
    previous_package_date="0" # The timestamp on the packages...
    for pkgname in ${names}; do
        if ! "${noop}"; then
            if [ ! -e "${pkgname}" ]; then
                message "Expected to find a package in '$(pwd)' called '${pkgname}'!"
                exit 1
            fi
            yes 'y' | sudo pacman ${pacman_args} -U "${pkgname}" > /dev/null
        fi

        # Check the timestamp on the package...
        local package_date="$(stat -c '%Y' "${pkgname}")"
        if [ "${package_date}" -gt "${previous_package_date}" ]; then
            previous_package_date="${package_date}"
        fi
    done
}

need_rebuild() {
    # Check if a the package in the current directory needs to be rebuilt.
    # It will print out a list of the package files that will be created, and 
    # will return 0 (true) if the packages need rebuilding, 1 (false) if they
    # don't.

    # Check that there exists an up-to-date package.
    local pkgdate="$(date '+%s')" # Set to now; time of youngest package.
    for pkgname in ${@}; do
        # Check that a symlink exists.
        if [ ! -e "${pkgname}" ]; then
            return 0
        fi

        # Update the youngest age of the packages...
        local currentpkgdate="$(stat -c "%Y" "${pkgname}")"
        if [ "${pkgdate}" -gt "${currentpkgdate}" ]; then
            pkgdate="${currentpkgdate}"
        fi
    done

    # Check that the package is up to date.
    local pkgbuilddate="$(stat -c "%Y" PKGBUILD)" # The age of the PKGBUILD.
    if [ "${pkgbuilddate}" -gt "${pkgdate}" ]; then
        return 0
    fi

    # Check if the prior package is _newer_ than this one...
    # This fixes the 'hacky' use of a DIRTY flag, and also fixes the bug where
    # the build system would not rebuild packages in the case of the build
    # being interrupted and restarted!
    #TODO: This is basically dependency related; if any of the deps are newer,
    #      rebuild. Instead, I'm hacking this... because deps are currently
    #      borked.
    if [ -n "${previous_package_date}" ] && [ "${previous_package_date}" -gt "${pkgdate}" ]; then
        return 0
    fi

    return 1
}

build() {
    # Build a given target!
    
    package="$1"

    check_arg_numbers 1 $@

    name="$(echo "${package}" | sed -e 's:.*/::')"
    prefix="$(echo "${package}" | sed -e "s:/${name}$::")"

    case "${prefix}" in
        toolchain) makepkg_args="-srf" pacman_args="" \
            build_package "${name}" "${prefix}";;
        packages) makepkg_args="-dLf --nocheck" \
            pacman_args="--config ${rootdir}/pacman.conf --noconfirm" \
            build_package "${name}" "${prefix}";;
        actions) $noop || "${rootdir}/${package}";;
        *) message "Unknown package prefix '${prefix}'!";;
    esac
}

parse_arguments() {
    # Parse the given arguments...

    for arg in $@; do
        case "${arg}" in
            --rebuild-all) REBUILD="${all}";;
            --rebuild=*) REBUILD="$(echo "${arg}" | sed 's:.*=::')";;
            -h|--help) echo "Usage: ${0} [-h|--help] [--rebuild=*|--rebuild-all]"
                exit 0;;
            *) echo "Unknown argument '${arg}'"; exit 1;;
        esac
    done
}

parse_arguments $@
if [ -n "${REBUILD}" ]; then
    echo "Ignoring --rebuild*; this does nothing!"
fi

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

message "Cleaned up and exited!"
