# Installation #

This guide assumes booting from the liveCD.

In QEMU:
``qemu-system-${arch} [-m, -cpu, ...] -cdrom ${iso} -hda ${disk image}``

## Systems setup ##

### Partition the hard drive ###

Replace /dev/sda with the path to the target disk.

``# parted /dev/sda mklabel msdos``

I start at 1M, end at -1 (the end of the disk).
``# parted /dev/sda mkpart primary``

Mark the partition as a boot partition:
``# parted /dev/sda toggle 1 boot``

### Create a filesystem ###

Using ext2, disabling 64bit as Syslinux cannot handle that yet:

``# mkfs.ext2 -L "${name}" -O ^64bit /dev/sda1``

Mount the filesystem:

``# mount /dev/sda1 /mnt``

### Populate the filesystem ###

Make a directory pacman needs:
``# mkdir -p /mnt/var/lib/pacman``

Now run pacman:
``# pacman --root /mnt --cachedir /repo -Syu base syslinux linux-generic``

### Chroot ###

```
# mount -t sysfs sys /mnt/sys
# mount -t tmpfs tmp /mnt/tmp
# mount -t devtmpfs dev /mnt/dev
# mount -t proc proc /mnt/proc
# chroot /mnt
```

### Install Syslinux ###

See
[the arch wiki](https://wiki.archlinux.org/index.php/Syslinux#Manual_install)
for more detailed instructions.
The alternative (``altmbr.bin``) method is probably better for simple systems;
also consider using lilo.

```
# cp -r /usr/lib/syslinux/bios/*.c32 /boot/syslinux
# extlinux --install /boot/syslinux
# dd bs=440 count=1 if=/usr/lib/syslinux/bios/mbr.bin of=/dev/sda
```

Configure /boot/syslinux/syslinux.cfg as required.

### Update fstab ###

Edit fstab as required.

### Create a default run script ###

/etc/init.d/init runs /etc/init.d/run.
A sensible default is starting a terminal on /dev/console:

```
#!/usr/bin/sh
/usr/bin/getty -l /usr/bin/login 0 /dev/console
```


## Adjusting the install ##

The system should now be bootable. However, some additional things should be
set up before using the install.

Other things to consider not listed here include timezones and the system
daemons.

### Hostname ###

``# echo "${hostname}" > /etc/hostname``

### Networking ###

See network.md.

### Users ###

Set the root password:

``# passwd``

Add a new user:

``# adduser ${username}``

### Locale ###

musl does not currently support locales.

