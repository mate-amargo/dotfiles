setxkbmap us,latam -option grp:alt_space_toggle -option caps:swapescape
wallchange
xrdb -merge ~/.Xresources
dunst -config ~/.config/dunstrc &
xss-lock -- screenlock &
xcompmgr &
exec awesome
