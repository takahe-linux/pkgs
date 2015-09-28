# My distro ideas! #

Like arch, but different :)

Well, not really.

Main differences:

- Different coreutils (?)
- Different libraries (musl vs glibc)
- i586
- Lighter...
- Wayland only (no X... unless Wayland doesn't really work.)
- Simpler - hopefully!
- Meta package: system (not a group - base). Only essentials...
- No initcpio!
- ???
- Statically compiled?
- Trying to avoid bash at all costs; go for more advanced shells or better
  intepreters/other languages.
- Using my defaults...

Similarities:

- systemd (was going to; now not so sure... doesn't work with musl?)
- pacman
- syslinux
- Simple...


I'd also like to avoid anything with excess dependencies, mostly for ease of
maintence.

Part of the idea is that it is ideally suited to cross compiling - modifying
makepkg is key to this idea! I'd like to create a database of computers +
specs that makepkg could use to determine what flags, etc, etc.

A future idea, anyway.


# Coreutils and Util-Linux #

Mmm...

It all depends...

The main reason is to try to cut down on the number of packages I have to
maintain!

Well, here are the options so far:

- Busybox: Nice, works, but is a bit... basic. And not the easiest thing to
  compile; it also limits flexibility in program selection!
- suckless utils: Not tried; seem alright
- Plan 9: Well, these are probably more out there. And not well-suited to
  linux.
- Other?

TODO: Research which coreutils to use...


# libc #

Musl wins here, hands down!

The only possible other option is uclibc, but only for a non-mmu unit (palm
pilot?)


# Compiler #

I've had bad experiences with building a gcc toolchain, so I'd prefer clang.
The real issue is figuring out how to build clang... without gcc.

I can compile the kernel with GCC, without a cross compiler (check?).
Since the hardware isn't able to do a self-hosted kernel compile, this would be
preferable.

I also would need to figure out how to get rid of gcc-libs... which could be
challenging, given what requires them! (Perl, for one)

Issues:

- I need to figure out, either how to build a cross-gcc, or how to get rid of
  the gcc-libs dependencies.


# Supported HW #

I'd like to support at least a Qemu VM and my Toshiba 310CDS.
That way, I can cross-compile to i586, then compile again (natively) on a more
powerful x86 machine (VM in this case (?)), finally booting on the Toshiba
using a i586 kernel. That way, it should be somewhat stable...

Basically, the distro should be self-hosting, except kernel support.
I think I'll leave building a kernel to more powerful machines...


# No initcpio #

This is mostly for speed, but also because a generic initcpio is often too
large for older machines to load. A custom kernel, in this case, is a must, so
an initcpio is a waste of time and resources.


# Bash #

Bash is a ridiculous language; I'd prefer to get rid of it entirely. There is
also better shells, in my opinion...
It's also not the easiest thing to build!

Issues:

- Bash is required for makepkg, which is... crucial.

