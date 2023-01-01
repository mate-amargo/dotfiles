~/.x/base.sh
xrdb -merge ~/.Xresources
xss-lock -- ~/.local/bin/screenlock &
compton &
exec i3
