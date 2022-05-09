~/.x/base.sh
xrdb -merge ~/.Xresources
dunst -config ~/.config/dunstrc &
xss-lock -- screenlock &
xcompmgr &
dwmstatus &
exec dwm
