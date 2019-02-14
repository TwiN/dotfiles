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
confirm "Install youtube-dl?" && sudo pacman -Sy --needed youtube-dl

if confirm "Install crunchy2mkv?"; then
	# install required dependencies
	sudo pacman -Sy --needed mkvtoolnix-cli youtube-dl
	sudo pip3 install crunchy2mkv
fi

