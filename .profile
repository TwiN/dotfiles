export EDITOR="nvim"

export LANG="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export HISTCONTROL=ignoredups

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"
export GO111MODULE=on

# Add ruby gem bin in path only if ruby is installed
if [[ $(ruby -e 'puts Gem.user_dir') == *'.gem'* ]]; then
	export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
fi

[[ -f ~/.bashrc ]] && source ~/.bashrc
