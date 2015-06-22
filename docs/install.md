# Installing Takahe Linux #

My notes on installing Takahe Linux:

1. Run build.sh
2. Fix any bugs... mount the image (using losetup -f --show -p, then mount),
   fix the bugs, the unmount the image and use losetup -d to destroy the loop
   device.
   Or, use some of the scripts in 'actions'...
3. Copy the resulting image (it will be /tmp/\*.img or something like that), or
   just point qemu at it.

