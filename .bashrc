[[ -f ~/.aliases ]] && source ~/.aliases

# Execute the following block only if the session is interactive 
if [[ -t 1 ]]; then
    bind 'set show-all-if-ambiguous on'
    bind 'TAB:menu-complete'
fi


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

xset r rate 250 25
