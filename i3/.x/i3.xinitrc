~/.x/base.sh
dbus-update-activation-environment --systemd DISPLAY
xrdb -merge ~/.Xresources
picom &
exec i3
