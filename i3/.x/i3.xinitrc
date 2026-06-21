~/.x/base.sh
dbus-update-activation-environment --systemd DISPLAY
picom &
exec i3
