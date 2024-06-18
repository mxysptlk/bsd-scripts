#! /usr/local/bin/zsh
# get pkg list
PKG_LIST=$(pkg search -r FreeBSD-base FreeBSD- | awk '{print $1}' | grep -v dbg | tr "\n" " ")
# install base pkgs
pkg install $(echo $PKG_LIST) # not sure why I had to use echo here
# reinstall displaced config files
echo "reinstalling displaced configs..."
for cfg in $(find /etc/ -name \*.pkgsave | sed -e 's/.pkgsave//'); do
    echo $cfg
    mv $cfg.pkgsave $cfg
done
echo "rebuilding /etc/mater.passwd"
# rebuild passwd and login dbs
pwd_mkdb -p /etc/master.passwd
echo " rebuilding login db"
cap_mkdb /etc/login.conf
echo "done"
