###########
# Aliases #
###########

alias ls="ls -hA --color=auto -F"
alias ll="ls -al"
alias l="ll"

alias battery="acpi -i"
alias volume="alsamixer"

alias r="ranger"


# Configuration shortcuts
alias ei3="vim ~/.config/i3/config"
alias ui3="cp ~/.config/i3/config ~/dotfiles/.config/i3/config"
alias epoly="vim ~/.config/polybar/config"
alias upoly="cp ~/.config/polybar/config ~/dotfiles/.config/polybar/config"
alias erc="vim ~/.bashrc"
alias urc="cp ~/.bashrc ~/dotfiles/.bashrc"


###############
# Fancy shell #
###############


COLOR_RED="\033[38;5;1m"
COLOR_ORANGE="\033[38;5;202m"
COLOR_YELLOW="\033[38;5;11m"
COLOR_LIGHTYELLOW="\033[38;5;228m"
COLOR_GREEN="\033[38;5;46m"
COLOR_GRAY="\033[38;5;240m"
COLOR_RESET="\033[0m"

#gitbranch=""
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
	source /usr/share/git/completion/git-prompt.sh 
	gitbranch="$COLOR_GRAY\$(__git_ps1)$COLOR_RESET"
fi 

export PS1="[$COLOR_RED\u$COLOR_RESET$COLOR_ORANGE@$COLOR_RESET$COLOR_YELLOW\h$COLOR_RESET $COLOR_LIGHTYELLOW\w$COLOR_RESET]$gitbranch $COLOR_GREEN\$$COLOR_RESET "


####################################################################
# Start display server (xorg) if i3 is installed and isn't running #
####################################################################

[ "$(tty)" = "/dev/tty1" ] && command -v i3 && ! pgrep -x i3 >/dev/null && exec startx
