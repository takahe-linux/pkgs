#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Create a system image, partition the device, and setup a loop device.
# Finally, mount the image on "${_sysroot}"

# Define some vars
#TODO: Make this configurable...
sysimage="/tmp/${_target_triplet}.img"
sysimage_size=400


# Define a cleanup function...
die() {
    # Arguments: <message> sysimage loopdev sysroot

    message=$1
    sysimage=$2
    loop=$3
    sysroot=$4

    error "${message}" > /dev/stderr

    if [ "z${sysimage}" != "z" ] && [ -f "${sysimage}" ]; then
        echo "Removing sysimage ${sysimage}"
        rm "${sysimage}"
    fi

    if [ "z${loop}" != "z" ] && [ -b "${loop}" ]; then
        echo "Cleaning up loop devices..."
        sudo losetup -d "${loop}"
    fi

    if [ "z${sysroot}" != "z" ] && [ -d "${sysroot}" ]; then
        echo "Removing sysroot dir..."
        rm -r "${sysroot}"
    fi

    exit 1
}

# Create a new system image
if [ -e "${sysimage}" ]; then
    message "System image '${sysimage}' already exists!"
    message "Overwrite? [y/N]"
    read input
    if [ "${input}" == "y" ]; then
        message "Overwriting system image '${sysimage}'" > /dev/stderr
    else
        die "Aborting; not overwriting system image!" "" "" ""
    fi
fi
dd if="/dev/zero" of="${sysimage}" bs=1M \
    count="${sysimage_size}" 2> /dev/stdout
# Check that the system image actually exists...
if [ ! -e "${sysimage}" ]; then
    die "Failed to create system image!"
fi

# Partition the new image
parted "${sysimage}" mklabel msdos 2> /dev/stdout
ERR="$?"
if [ "${ERR}" != 0 ]; then
    die "Creating a partition table failed; got a return value of ${ERR}!"
fi
parted "${sysimage}" mkpart primary 2 "${sysimage_size}" 2> /dev/stdout
ERR="$?"
if [ "${ERR}" != 0 ]; then
    die "Creating a partition failed; got a return value of ${ERR}!"
fi
echo "Created and partitioned the new disk image"

# Use losetup to create a new loop device.
loop="$(sudo losetup -f --show -P "${sysimage}")"
echo "Setup a new loop device on ${loop}"
sleep .1
if [ ! -b "${loop}p1" ]; then
    die "Expected a loopdev (${loop}p1)!" "${sysimage}" "${loop}" ""
fi

# Make a new filesystem on the disk
#TODO: Make this configurable...
sudo mkfs.ext2 "${loop}p1" -L "Takahe Linux" 2> /dev/stdout
echo "Created a new filesystem on '${loop}p1'"

# Make the new sysroot directory
if [ -e "${_sysroot}" ]; then
    die "Sysroot dir ${_sysroot} already exists!" "${sysimage}" "${loop}" ""
fi
sudo mkdir -p "${_sysroot}"

# Mount the new filesystem on the sysroot
sudo mount "${loop}p1" "${_sysroot}"
echo "Mounted the loop device on ${_sysroot}"

