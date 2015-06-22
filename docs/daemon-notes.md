# Daemon Notes #

This document is my notes on daemons that I could use for Takahe Linux.
I intend to create a list of daemons that I should use, a list of alternatives
I've found, and some notes on which ones I am/will use and why.

## Logger ##

The logger daemon traditionally is syslog.
In systemd, it is journald.

It's a core component of any system, but I have yet to find one I like.

## Time sync ##

Normally handled by ntpd, or, on systemd, timesyncd.

## Login ##

The two apparent options are Console-Kit or logind, which is systemd-specific.

Currently I just don't support multiseat.

## IPC ##

D-bus traditionally, but I'm not sure that I really want to run a daemon just
for system communication...

Sockets and so forth appear to work just as well, although I can understand the
need for a library over them to try to smooth out the wrinkles.

## Device detection ##

There appears to be three choices here:

- mdev (from busybox)
- udev (most likely [eudev](https://github.com/gentoo/eudev))
- mdev (from toybox)

I'm using mdev, which appears to do everything I want. I'd like something with
a few more features, ie reading from a bunch of files which can be installed by
packages, but it works, so...
I'm not sure what udev can do that mdev can't; I have yet to find anything.

I would like to look for a standalone alternative...

See [the gentoo wiki](https://wiki.gentoo.org/wiki/Mdev) for more information,
or the [mdev primer](https://git.busybox.net/busybox/plain/docs/mdev.txt).

udev has plenty of existing documentation.

Also, there is a minimal devd implementation in both C and shell 
[here](https://lkml.iu.edu/hypermail/linux/kernel/0510.3/1853.html).

## Init ##

Highly important :)

There are many choices, see [here](https://www.troubleshooters.com/linux/init/features_and_benefits.htm) for a (biased against systemd) overview.
Personally, I like some features of systemd, so have gone for Epoch.
Epoch suffers from some of the issues of mdev, ie it appears to be harder to
install default service files (to use some systemd vocabulary) with packages,
but otherwise it's fairly good.
There are a few 'missing' features, but it's better than the alternatives...

Note: Epoch, as it turns out, has a few bugs. The 'custom' IPC system is flaky,
      for instance...

## Cron ##

I'd like the init to do this, just because it seems easier, but otherwise I
suspect [dcron](https://www.jimpryor.net/linux/dcron.html) is the best bet.
It appears to be lightweight and semi-sane...

## sshd ##

No idea on this yet :(

## Networking ##

Well, I'm currently leaning towards using {u,m}dev scripts for this, but as
I have yet to test that idea I'm less certain.

## Zeroconf ##

I'd love bonjour/avahi style zeroconf networking.
The trouble appears to be that I need either avahi or bonjour, neither of
which are lightweight. I need to do some rudimentary memory usage profiling...

## WPA ##

wpa\_supplicant appears to be the only option. I'm not a fan, but it works...

Using {u,m}dev to autostart as required might be the best option, although
starting only when I need networking would be even better...

## Dynamic permissions ##

Policy-Kit appears to try to handle this, but as far as I can tell, it's not
something that makes sense for my use case.
I'll have another look if I run across anything that needs this.

## Print server ##

Ummm... cupsd?

I have yet to look.

## Generic servers ##

ftp/http/gopher/mail servers are not something I consider I should be choosing,
since they aren't really core to the OS.
Nor have I really looked :)

## Monitor controls ##

Redshift, colour profiles, monitor dimming... stuff I can get excited about :)
I think that colord handles some of this on systemd systems, but I suspect I
don't really need a daemon running just for this - I'll revisit it if I ever
have a system with an integrated webcam.


