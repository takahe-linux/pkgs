# Network setup #

See [this question](www.linuxquestions.org/questions/linux-networking-3/how-can-i-use-udhcpc-800236/)
for an existing script for udhcpc.

Basically, we need to:

- Set the interface to up (also do this for the localhost network)
  ip link set eth0 up
  ip link set lo up
- Run udhcpc to acquire a default ip address
- Add that address to the interface: ip addr add $IP/24 dev eth0
- Add a default route: ip route add default via $GATEWAY dev eth0
- Add a resolv.conf ("nameserver 8.8.8.8" will do fine)
- Check hostname, hosts

For qemu, $GATEWAY is 10.0.2.2.
