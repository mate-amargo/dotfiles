#!/usr/bin/env sh

dbus-send \
	--session \
	--dest=org.Xmobar.Control \
	--type=method_call \
	--print-reply \
	'/org/Xmobar/Control' \
	org.Xmobar.Control.SendSignal \
	"string:Toggle 0"
