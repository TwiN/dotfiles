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

confirm "Install rtv (Reddit viewer for terminal)?" && sudo pacman -Sy --needed rtv
confirm "Install lastpass-cli?" && sudo pacman -Sy --needed lastpass-cli


