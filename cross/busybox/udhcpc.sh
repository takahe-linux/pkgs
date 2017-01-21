#!/usr/bin/busybox hush
#
# udhcpc/default.script
#
# Default udhcpc event handler script.
# This script is called by udhcpc when events occur - for more information, see
# udhcp.busybox.net/README.udcpc.
#
# Author:	Alastair Hughes
# Date:		21-1-2017

[ "$#" -ne 1 ] && echo 'Not enough arguments' && exit 1

# rebind - set up the defaults for the interface.
rebind() {
	ip addr flush dev "${interface}"
	ip addr add "${ip}/${mask}" dev "${interface}"
	if [ -n "${router}" ]; then
		ip route add default via "${router%% *}" dev "${interface}"
	fi
}

case "$1" in
	deconfig)
		# deconfig - called when udhcpc starts, and when leases are lost.
		ip link set "${interface}" up
	;;
	bound|renew)
		# bound - called when udhcpc has bound to an interface.
		# renew - called when a lease is renewed.
		# We rebind for both bound and renew events, although it would probably be
		# more efficient to just apply any differences.
		rebind
	;;
	nak)
		# nak - called when udhcpc fails to get a lease.
		# We don't do anything here, but we could log the failure.
	;;
esac
