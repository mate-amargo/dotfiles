# ~/.bashrc
# Read by interactive non-login shells (new terminal window/tab, nested bash)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.bash_functions
source ~/.bash_aliases

HISTTIMEFORMAT="[%d/%m/%Y %T] "
HISTSIZE=1000
HISTFILESIZE=1000
HISTCONTROL=ignoreboth
