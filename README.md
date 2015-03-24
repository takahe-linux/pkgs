# Overview #

Takahe Linux is my experimental Linux distro, dedicated to 'extinct' computers.

It is supposed to be a learning experience for me, and an opportunity to play
around with some different software.

I will be testing it on what hardware I have, mostly Qemu and a Toshiba 310CDS
laptop.

I hope to support older computers, and those of weirder architectures. If you
are looking for a lightweight (ish) system for more modern computers, [Arch
Linux](https://www.archlinux.org) is the way to go!


# Status #

Currently, I have managed to build the toolchain, and a basic system bootable
in [Qemu](https://wiki.qemu.org/Main_Page).

I plan to work from here, until I get to a workable stage.


# Testing #

Since I have no working bootloader, testing is a little difficult...

I plan to upload a working system image to Bitbucket, but only once I've added
a bootloader and generally made a working system.

Until then, I am using the kernel and append options for qemu to test images.

I also want to have an end-to-end build script. Currently, this is messy, but
I'm giving it a go in the form of shell scripts. The main issue is that
the tools I'm using do not handle cross-compiling well...


# Future plans #

I've got some ideas of where to go from here!

## Toolchain ##

Currently, everything is good here. However, I'd like to make it less dependent
on the host system (read: building it's own mpfr/mpc and so on).

## System ##

I'd like to add some automation here. The current script is a good start, but
is still missing some 'key' functionality, and it's pretty dumb - it rebuilds
_everything_, not just what needs to be rebuilt.
I also need to add a bootloader, and prove to myself that it boots on my test 
machine, as well as in Qemu.

The eventual goal is to make the system capable of then building itself - with
the system created by the cross-compile toolchain becoming a 'temporary' system
between architectures.

Of course, such a system would also be able to bootstrap other architectures,
and generally do everything I'd like it to do...

I'd also like to hack makepkg to ensure that it works better with a distinction
between the host and target systems, but that's a job for another day.


# Goals #

The long-term goal of Takahe linux is to provide a working system, based on
the musl libc, the Linux kernel, and some userspace tools.

I would also like it to be self-hosting: a system running Takahe Linux can
build another system, also running Takahe Linux.
Preferably, it would also be easy to bootstrap to new architetures (at least
those supported by Linux and Musl - at the moment, realistically that means
ARM and x86-64 as I have hardware for both.

In the future, I'd love to be building and maintaining a Linux distro
entirely from 'vintage' computers - but I'd need something a bit more grunty
than my Toshiba to do that!


# Takahe #

The Takahe is a flightless New Zealand bird, which was thought to be extinct.
However, it was rediscovered in 1948...

For more information, see [Wikipedia's article](https://en.wikipedia.org/wiki
/Takahe "Takahe (Wikipedia)").


# Naming scheme #

Following on from the idea that Takahe Linux is helping extinct birds (in this
case, older computers) fly again, I plan to name releases after extinct NZ
birds.

Wikipedia (again) has [an article](https://en.wikipedia.org/wiki
/List_of_extinct_animals_of_New_Zealand#Birds "Extinct NZ birds (Wikipedia)")
listing them.


# Who am I? #

I am myself!

Who else :)

More seriously, I am not a distro maintainer, developer, or any other such
title. Experimenter, really. Keep that in mind if you decide to try this distro!

Not that I expect anyone will for a while...


# Contributing #

TODO: Fill in

