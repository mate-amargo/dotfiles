#!/bin/bash
# Toggle between xcompmgr -> picom -> Nothing


if [[ -z $(pgrep xcompmgr)  && -z $(pgrep picom) ]]; then # Nothing -> xcompmgr
	xcompmgr &
elif [[ -z $(pgrep picom) ]]; then # xcompmgr -> picom
	killall xcompmgr
	picom &
else # picom -> Nothing
	killall picom
fi

#pgrep picom && killall picom && (xcompmgr &) || pgrep xcompmgr && killall xcompmgr && (picom &) || (xcompmgr &)
