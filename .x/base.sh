#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
setxkbmap -layout "us,ru" -variant "altgr-intl," -option nodeadkeys -option caps:swapescape -option grp:alt_space_toggle

multimonitor
