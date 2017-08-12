# Network setup

- Run udhcpc to acquire a default ip address
- Add a resolv.conf ("nameserver 8.8.8.8" will do fine)
- Check hostname, hosts

If you are using a wifi dongle, consider adding the following lines to
`/etc/mdev.conf`:

```
# Autostart wpa_supplicant when we plug in a wireless NIC.
-SUBSYSTEM=net;INTERFACE=wlan.*;.*  0:0 700 @/usr/bin/bh-start wpa_supplicant@$INTERFACE
-SUBSYSTEM=net;INTERFACE=wlan.*;.*  0:0 700 $/usr/bin/bh-stop wpa_supplicant@$INTERFACE
# Autostart udhcpc on new wireless interfaces.
-SUBSYSTEM=net;INTERFACE=wlan.*;.*  0:0 700 @/usr/bin/bh-start udhcpc@$INTERFACE
-SUBSYSTEM=net;INTERFACE=wlan.*;.*  0:0 700 $/usr/bin/bh-stop udhcpc@$INTERFACE
```

