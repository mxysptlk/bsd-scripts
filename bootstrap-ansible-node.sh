#!/bin/sh
mkdir -p /usr/local/etc/pkg/repos
cat << EOF >> /usr/local/etc/pkg/repos/FreeBSD.conf
FreeBSD { enabled: no }
FreeBSD-ports {
  url: "pkg+https://pkg.FreeBSD.org/\${ABI}/latest",
  mirror_type: "srv",
  signature_type: "fingerprints",
  fingerprints: "/usr/share/keys/pkg",
  enabled: yes
}
EOF

pkg bootstrap -y
pkg install -y python
