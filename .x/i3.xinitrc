~/.x/base.sh
xrdb -merge ~/.Xresources
xss-lock -- screenlock &
exec i3
