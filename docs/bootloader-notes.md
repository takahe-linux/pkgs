# Bootloader Notes #

This document is intended to hold my (personal) notes on the bootloaders
I've looked at. Hopefully it will be of use when others are deciding what
they will use.

## Grub ##

I'm not that familiar with grub. I was using it for testing my system
because it was on the LFS CD (the only CD I've found that booted).

It's _terribly slow_. It could be my fault, but it added several seconds
to the system boot. When the system only takes 17 seconds (it's old),
having to wait 5+ seconds for the bootloader is just annoying.

It could, of course, be my configuration.
Or the choice of compression algorithm for the kernel.
Or some other factor.

## Syslinux ##

I use this on my 'main' systems. It's easy to use, modular, but apparently
near impossible to cross compile in a sane fashion. I tried.
I've also failed to strip out all of the bits I don't use in a sane manner.

I will revist this once I've got a working system.

## Barebox ##

Barebox is a fork of uboot.

This is what I'd like to use. Minimal; yes. But it apparently works on
nearly anything, [including a pc](https://wiki.barebox.org/doku.php?id=user;pc-bootloader).
It should be reasonably fast, too...

For chain loading and other similar features (dual boot, network boot, and so
on) it's probably not a good choice.

## Grub 2 ##

Haven't tried.

## Any UEFI bootloader ##

Again, haven't tried and don't intend to. I'm lacking UEFI hardware for a
start...

## Lilo ##

Again, haven't tried. Looks fairly promising, but possibly a bit limited.



