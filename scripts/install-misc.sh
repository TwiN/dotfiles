#!/bin/bash

confirm() {
    read -r -p "${1:-Are you sure?} [Y/n] " response
    case "$response" in
        [nN][oO]|[nN]) 
            false
            ;;
        *)
            true
			;;
    esac
}

confirm "Install rtv (Reddit viewer for terminal)?" && sudo pacman -Syu --needed rtv
confirm "Install lastpass-cli?" && sudo pacman -Syu --needed lastpass-cli
confirm "Install youtube-dl?" && sudo -H pip install --upgrade youtube-dl
confirm "Install virtualbox?" && sudo pacman -Syu --needed virtualbox
