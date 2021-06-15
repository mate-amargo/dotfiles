#!/bin/bash
#
# Startup file executed for login shells

# Load functions and aliases
source ~/.bash_functions
source ~/.bash_aliases

# History settings
export HISTTIMEFORMAT="[%d/%m/%Y %T] "
export HISTSIZE=1000
export HISTFILESIZE=1000
#export HISTFILE="$HOME/log/$(tty | cut -c 6-)/$(date +%Y-%m-%d)"
export HISTCONTROL=ignoreboth

# Set the prompt
#source ~/.epc/epcrc

# Set the path
#export PATH=${PATH}:/usr/games/bin:/lib/android-sdk/tools:/lib/android-sdk/platform-tools

export BROWSER="google-chrome-stable"

# Autostart X
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
#[[ -z $DISPLAY && ! $(ps -u $(whoami) | grep X) ]] && exec startx
[[ -z $DISPLAY && ! $(ps -u $(whoami) -o comm| grep Xorg) ]] && exec startx

# Display calendar
#pal -r 1

# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

source /home/e4/.config/broot/launcher/bash/br
