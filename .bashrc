alias ls="ls -A --color=auto -F"
alias ll="ls -al"

alias battery="acpi"


export PS1="[\[$(tput sgr0)\]\[\033[38;5;1m\]\u\[$(tput sgr0)\]\[\033[38;5;202m\]@\[$(tput sgr0)\]\[\033[38;5;220m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \w] \[$(tput sgr0)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

# Start display server (xorg) if i3 is installed and isn't running
[ "$(tty)" = "/dev/tty1" ] && command -v i3 && ! pgrep -x i3 >/dev/null && exec startx

