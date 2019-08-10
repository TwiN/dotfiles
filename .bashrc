###########
# Aliases #
###########

alias ls="ls -hA --color=auto -F"
alias ll="ls -al"
alias l="ll"

alias battery="acpi -i"
alias volume="pavucontrol"
alias current-driver-loaded-by-xorg="sudo lsof +D /usr/lib/xorg/modules/drivers/"

alias switch-python2="sudo ln -sf python2 /usr/bin/python"
alias switch-python3="sudo ln -sf python3 /usr/bin/python"

alias r="ranger"
alias yt="youtube-dl -x --audio-format mp3 -o \"%(title)s.%(ext)s\" "
alias k="kubectl"

# Configuration shortcuts
alias ei3="vim ~/.config/i3/config"
alias ui3="cp ~/.config/i3/config ~/dotfiles/.config/i3/config"
alias epoly="vim ~/.config/polybar/config"
alias upoly="cp ~/.config/polybar/config ~/dotfiles/.config/polybar/config"
alias erc="vim ~/.bashrc"
alias urc="cp ~/.bashrc ~/dotfiles/.bashrc"

# Lazy shortcuts
alias gohome="cd $GOPATH/src/github.com/TwinProduction"
alias connect-bluetooth-speaker="echo -e 'power on\nconnect 00:42:79:AF:85:C9\n' | bluetoothctl"
alias disconnect-bluetooth-speaker="echo -e 'disconnect 00:42:79:AF:85:C9\npower off\n' | bluetoothctl"
alias mirror-screen="xrandr --output DP2 --same-as eDP1 --mode 1600x900"

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
###################################################################

[ "$(tty)" = "/dev/tty1" ] && command -v i3 && ! pgrep -x i3 >/dev/null && exec startx
