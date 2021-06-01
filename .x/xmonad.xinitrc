setxkbmap us,latam -option grp:alt_space_toggle -option caps:swapescape
xrdb -merge ~/.Xresources
dunst -config ~/.config/dunstrc &
xss-lock -- screenlock &
redshift &
xcompmgr &
wallchange
xmonad --recompile
exec xmonad
