~/.x/base.sh
dbus-update-activation-environment --systemd DISPLAY
picom &
xmonad --recompile
exec xmonad
