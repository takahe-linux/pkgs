# Distro overview #

Differences from Arch:

- Different core userspace (busybox, musl libc, (currently) epoch init, ...)
- Statically compiled.
- Supports different architectures (currently, mips).
- No initcpio.

Similarities:

- pacman


# Coreutils and Util-Linux #

Busybox, but other alternatives include the suckless, heirloom, plan 9, and
toybox versions.


# libc #

Musl wins here, hands down!


# Compiler #

gcc is complex, but is widely supported.
If someone makes a simpler cc, I might use that on the system, as it is likely
only going to be used to compile 'toy' projects.


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

Bash is required for makepkg.
It has a few too many features for my liking, but I'm resigned to having it at
this point...

