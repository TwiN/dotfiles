#!/bin/bash

confirm() {
    read -r -p "${1:-Are you sure?} [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

if confirm "Install base packages (vim base-devel go mlocate wpa_supplicant iw git) (recommended)?"; then
    echo -e "\e[32mInstalling some necessary packages\e[0m"
    sudo pacman -Sy vim base-devel go mlocate wpa_supplicant iw git
    
    echo -e "\e[32mSetting GOPATH and GOBIN to /go and /go/bin respectively in /etc/environment\e[0m"
    echo 'GOPATH="/go"' | sudo tee -a /etc/environment >> /dev/null
    echo 'GOBIN="/go/bin"' | sudo tee -a /etc/environment >> /dev/null

    echo -e "\e[32mUpdating mlocate's database (use locate to search for a file)\e[0m"
    sudo updatedb
fi

confirm "Install openjdk?" && sudo pacman -Sy jdk-openjdk
confirm "Install firefox-developer-edition?" && sudo pacman -Sy firefox-developer-edition
confirm "Install aws-cli?" && sudo pacman -Sy aws-cli

if confirm "Install yay as AUR helper?"; then
    echo -e "\e[32mInstalling yay as AUR helper\e[0m"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    echo "Cleaning up"
    rm -rf yay
fi

confirm "Install xorg and xorg-xinit?" && sudo pacman -Sy xorg xorg-xinit

