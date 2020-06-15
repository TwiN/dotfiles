if type "dyr" > /dev/null; then 
	dyr get --random
fi

[[ -f ~/.aliases ]] && source ~/.aliases

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

###############
# Fancy shell #
###############

COLOR_RED="\[$(tput setaf 1)\]"
COLOR_ORANGE="\[$(tput setaf 202)\]"
COLOR_YELLOW="\[$(tput setaf 11)\]"
COLOR_LIGHTYELLOW="\[$(tput setaf 228)\]"
COLOR_GREEN="\[$(tput setaf 10)\]"
COLOR_GRAY="\[$(tput setaf 240)\]"
COLOR_RESET="\[$(tput sgr0)\]"
FONT_BOLD="\[$(tput bold)\]"

if [ -f /usr/share/git/completion/git-prompt.sh ]; then
	source /usr/share/git/completion/git-prompt.sh 
	gitbranch="$COLOR_GRAY\$(__git_ps1)$COLOR_RESET"
fi 

export PS1="[$COLOR_RED\u$COLOR_RESET$COLOR_ORANGE@$COLOR_RESET$COLOR_YELLOW\h$COLOR_RESET $COLOR_LIGHTYELLOW\w$COLOR_RESET]$gitbranch $COLOR_GREEN\$$COLOR_RESET "


####################################################################
# Start display server (xorg) if i3 is installed and isn't running #
####################################################################

[ "$(tty)" = "/dev/tty1" ] && command -v i3 && ! pgrep -x i3 >/dev/null && exec startx
