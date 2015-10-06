#!/usr/bin/env sh
#
# Build script for Takahe Linux.
#
# Author:   Alastair Hughes
# Contact:  < hobbitalastair at yandex dot com >

set -e

# Add the rootdir and adjust the PATH to include the scripts...
export rootdir="$(dirname $(realpath $0))"
export PATH="${rootdir}/scripts:${PATH}"

#
# Define build variables
#

all="targets/setup \
    targets/toolchain \
    targets/base \
    targets/build \
    targets/cleanup"

# This is for testing purposes. It will cause the program to print out what it
# would build instead of actually doing it...
export noop="false"

#
# Define the helper functions
#

error() {
    errno="$1"
    shift
    "${rootdir}/scripts/error" $@
    exit "${errno}"
}


#
# Main body
#
parse_arguments() {
    # Parse the given arguments...

    for arg in $@; do
        case "${arg}" in
            --rebuild-all) REBUILD="${all}";;
            --rebuild=*) REBUILD="${REBUILD} $(echo "${arg}" | sed 's:.*=::')";;
            -h|--help) message "Usage: ${0} [-h|--help] [--rebuild=*|--rebuild-all]";
                exit 0;;
            *) error "Unknown argument '${arg}'"; exit 1;;
        esac
    done

    # 'touch' the PKGBUILD's of the packages that need rebuilding.
    # This should make them rebuild - fingers crossed.
    for pkg in ${REBUILD}; do
        pkgbuild="${rootdir}/${pkg}/PKGBUILD"
        # Check that the PKGBUILD exists!
        if [ ! -f "${pkgbuild}" ]; then
            error "Unknown package '${pkg}'!"
            exit 1
        fi
        # 'touch' the given PKGBUILD.
        touch "${pkgbuild}"
    done
}

parse_arguments $@

# Setup sudo_keepalive
#TODO: Remove this... building using root _is_ dangerous!
# Just in case anyone thinks this is a good idea; it's not.
# I just haven't got around to hacking up a workaround...
sudo message "Sudo working, thanks!"
"${rootdir}/scripts/keepalive" "$$" "240" sudo true &
KEEPALIVE_PID="$!"

for target in ${all}; do
    build "${target}"
done

# Clean up the helper processes
kill "${KEEPALIVE_PID}"
wait 2> /dev/null

message "Cleaned up and exited!"
