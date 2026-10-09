# ~/.bash_profile
# Read by login shells only (TTY login, ssh, bash -l) once per session.

export PATH=${HOME}/.local/bin:${PATH}
export BROWSER="google-chrome-stable"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

[[ -f ~/.bashrc ]] && . ~/.bashrc
