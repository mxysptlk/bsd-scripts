#! /usr/local/bin/zsh
# get pkg list
PKG_LIST=$(pkg search -r FreeBSD-base FreeBSD- | awk '{print $1}' | grep -v dbg | tr "\n" " ")
# install base pkgs
pkg install $PKG_LIST
# reinstall displaced config files
for cfg in $(find /etc/ -name \*.pkgsave | sed -e 's/.pkgsave//'); do
    mv $cfg.pkgsave $cfg
done
# rebuild passwd and login dbs
pwd_mkdb -p /etc/master.passwd
cap_mkdb /etc/login.conf
