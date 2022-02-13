setxkbmap us,latam -option grp:alt_space_toggle -option caps:swapescape
xrdb -merge ~/.Xresources
dunst -config ~/.config/dunstrc &
xss-lock -- screenlock &
xcompmgr &
wallchange
xmonad --recompile
xrandr --output LVDS1 --auto --output HDMI1 --auto --above LVDS1
exec xmonad
