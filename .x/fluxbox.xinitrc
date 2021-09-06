#!/bin/sh
setxkbmap us,latam -option grp:alt_space_toggle -option caps:swapescape
wallchange
#xsetroot -solid \#006060
xrdb -merge ~/.Xresources
#dunst -config ~/.config/dunstrc &
#xss-lock -- screenlock &
#xcompmgr &
fluxbox
