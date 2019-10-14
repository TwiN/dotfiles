export EDITOR="nvim"

export LANG="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

export GO111MODULE=on

export MONITOR_DISPLAY_NAME=$(xrandr --listmonitors | awk 'NR==2 {print $4}')

[[ -f ~/.bashrc ]] && . ~/.bashrc
