# Overview #

_Note that Takahe Linux is on indefinite hiatus as I am currently experimenting with other things..._

Takahe Linux is my experimental Linux distro, dedicated to 'extinct' computers.

It is supposed to be a learning experience for me, and an opportunity to play
around with some different software.

I will be testing it on what hardware I have, mostly Qemu and a Toshiba 310CDS
laptop.

I hope to support older computers, and those of weirder architectures. If you
are looking for a lightweight (ish) system for more modern computers, [Arch
Linux](https://www.archlinux.org) is the way to go!


# Status #

I have created most of the packages I want to build, and the system works on my
target machine (a toshiba laptop).
The system is also bootable in [Qemu](https://wiki.qemu.org/Main_Page).

Remaining targets are listed in docs/roadmap.md.


# Testing #

I intend to make a live CD available for i586 machines in the near future.

Building from scratch is achievable using the
[build utilities](https://bitbucket.org/Alastair_Hughes/takahe-build) and this
repository.


# Goals #

The long-term goal of Takahe linux is to provide a working system, based on
the musl libc, the Linux kernel, and some userspace tools.

I would also like it to be self-hosting: a system running Takahe Linux can
build another system, also running Takahe Linux.
Preferably, it would also be easy to bootstrap to new architectures.

In the future, I'd love to be building and maintaining a Linux distro
entirely from 'vintage' computers - but I'd need something a bit more grunty
than my Toshiba to do that!


# Takahe #

The Takahe is a flightless New Zealand bird, which was thought to be extinct.
However, it was rediscovered in 1948...

For more information, see [Wikipedia's article](https://en.wikipedia.org/wiki/Takahe%20%22Takahe%20(Wikipedia)%22).


# Naming scheme #

Following on from the idea that Takahe Linux is helping extinct birds (in this
case, older computers) fly again, I plan to name releases after extinct NZ
birds.

Wikipedia (again) has [an article](https://en.wikipedia.org/wiki/List_of_extinct_animals_of_New_Zealand#Birds%20%22Extinct%20NZ%20birds%20(Wikipedia)%22)
listing them.


# Caveat #

I am just experimenting here, so there will be rough edges, broken packages,
security holes, and other issues. Feel free to contribute and help fix them!


# Contributing #

Feel free to send patches or pull requests! I'll be happy to take a look at
them.

