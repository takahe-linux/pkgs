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

setup="actions/clean_sysroot.sh \
    actions/clean_toolchain.sh \
    actions/mount_sysroot.sh \
    actions/prepare_sysroot.sh"

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

all="${setup} ${toolchain} ${base} ${cleanup}"

# This is for testing purposes. It will cause the program to print out what it
# would build instead of actually doing it...
noop="false"

#
# Define the main functions
#

message() {
    echo ">>> $@"
}

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

    if $noop; then
        message "Building remote package ${prefix}/${name}"
        return 0
    fi

    cd "${rootdir}/${prefix}/${name}"

    yes 'y' | makepkg --config ../makepkg.conf -sricf
}

build_target() {
    # Build a given package for the target machine.

    check_arg_numbers 2 $@

    if $noop; then
        message "Building toolchain package ${prefix}/${name}"
        return 0
    fi

    cd "${rootdir}/${prefix}/${name}"

    # Run makepkg
    # Disable checks since they probably won't work
    makepkg --config ../makepkg.conf -dfL --nocheck

    sudo pacman --config "${rootdir}/pacman.conf" -U *.pkg.tar.* --noconfirm
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

sudo_keepalive() {

    # Record the parent PID
    parent_pid="$1"

    # Set up some vars
    sudo_retry=240 # Number of seconds between sudo calls

    while true; do
        sudo true
        echo ">>> heartbeat!"
        
        time_to_sudo="${sudo_retry}"
        while [ "${time_to_sudo}" -gt 0 ]; do
            
            # Check on the parent process
            if kill -0 ${parent_pid} 2> /dev/null ; then
                # All is well
                sleep 1
            else
                echo ">>> heartbeat stopped; sudo_keepalive is exiting..."
                return 0 # Parent has died; exit
            fi

            # Subtract off another waiting second...
            time_to_sudo="$(expr "${time_to_sudo}" - 1)"

        done
    done
}

# Setup sudo_keepalive
sudo echo "Sudo working, thanks!"
sudo_keepalive "$$" &
KEEPALIVE_PID="$!"

#TODO: Add argument parsing for more functionality

# Build
if [ "$1" == "" ]; then
    FIRST="$(echo $all | cut -d' ' -f1)"
else
    FIRST="$1"
fi

BUILDING="false"
for package in $all; do
    if ${BUILDING} || [ "${package}" == "${FIRST}" ]; then
        BUILDING="true"
        build "${package}"
    fi
done

if ! "${BUILDING}"; then
    echo "Error: start package '${FIRST}' does not exist"
fi

# Clean up the helper processes
kill "${KEEPALIVE_PID}"
wait

message "Cleaned up and exited!"
