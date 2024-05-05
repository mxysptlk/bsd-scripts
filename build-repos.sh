#!/bin/sh
#
PKG_LIST=/usr/local/poudriere.d/pkglist.txt
BIN_POUDRIERE=/usr/local/bin/poudriere

JAIL=14amd64

SCRIPTNAME=`basename "$0"`
STATUS=`ps -ax | grep "$SCRIPTNAME" | grep -v grep | wc -l`

if [ "$STATUS" -gt 2 ]; then
        echo "already running."
            exit 0
fi

$BIN_POUDRIERE ports -u
if [ $? -ne 0 ]; then
    echo "Error updating ports tree"
    exit 1
fi

$BIN_POUDRIERE bulk -j $JAIL -p default -f $PKG_LIST -b latest
