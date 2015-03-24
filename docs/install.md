# Installing Takahe Linux #

My notes on installing Takahe Linux:

1. Run build.sh
2. Fix the bugs...
3. Unmount the sysroot
4. Unset the loop device (/dev/loop something, whatever was mounted on the 
   sysroot - you did take note, right?)
5. Copy the resulting image (it will be /tmp/\*.img or something like that), or
   just point qemu at it.

# Known bugs #

Currently, you manually need to link /lib/ld-linux-musl.so.1 to 
/usr/lib/libc.so, and install a fstab of some sort.

