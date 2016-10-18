post_install() {
  if type -P systemd-tmpfiles >/dev/null; then
    systemd-tmpfiles --create sudo.conf
  fi
}

pre_upgrade() {
  # Permissions of /var/db/sudo were changed from 0700 to 0711 in sudo 1.8.10
  # http://www.sudo.ws/repos/sudo/rev/5c38d77a2d0c
  if (($(vercmp $2 1.8.10-1) < 0)); then
    chmod 0711 var/db/sudo
  fi
}

post_upgrade() {
  post_install
}

# vim:set ts=2 sw=2 et:
