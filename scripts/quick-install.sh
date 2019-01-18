#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo -e "\e[31mDo not execute this as root\e[0m"
    exit 1
fi

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

if confirm "Install base packages (recommended)?"; then
    # base-devel needs to be installed separately because it's a package group
    echo -e "\e[32m> Installing base-devel\e[0m"
    sudo pacman -Sy --needed base-devel
    
    echo -e "\e[32m> Installing some necessary packages\e[0m"
    sudo pacman -Sy --needed vim go mlocate wpa_supplicant iw git wget dialog screenfetch htop rxvt-unicode xterm
    
    echo -e "\e[32m> Setting GOPATH and GOBIN to /go and /go/bin respectively in /etc/environment\e[0m"
    echo 'GOPATH="/go"' | sudo tee -a /etc/environment >> /dev/null
    echo 'GOBIN="/go/bin"' | sudo tee -a /etc/environment >> /dev/null

    echo -e "\e[32m> Updating mlocate's database (use locate to search for a file)\e[0m"
    sudo updatedb
fi

if confirm "Install yay as AUR helper?"; then
    echo -e "\e[32m> Installing yay as AUR helper\e[0m"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    echo "> Cleaning up"
    rm -rf yay
    confirm "Install urxvt plugins?" && yay -S urxvt-resize-font-git
    confirm "Install Siji glyph fonts?" && yay -S siji-git
fi

if confirm "Install acpi to view your battery status?"; then
    echo -e "\e[32m> Installing acpi\e[0m"
    sudo pacman -Sy --needed acpi
    if confirm "Create alias 'battery' for acpi in your .bashrc?"; then
        echo -e "\e[32m> Creating alias 'battery' for acpi\e[0m"
        echo 'alias battery="acpi"' | sudo tee -a ~/.bashrc >> /dev/null
    fi
fi

confirm "Install openjdk?" && sudo pacman -Sy --needed jdk-openjdk
confirm "Install firefox-developer-edition?" && sudo pacman -Sy --needed firefox-developer-edition
confirm "Install aws-cli?" && sudo pacman -Sy --needed aws-cli
confirm "Install fonts?" && sudo pacman -Sy --needed ttf-hack ttf-inconsolata adobe-source-code-pro-fonts ttf-dejavu terminus-font ttf-freefont xorg-xfd
confirm "Install feh (Image viewer and desktop wallpaper manager)?" && sudo pacman -Sy --needed feh


########
# MISC #
########

# Enable colors for pacman 
sed -i "s/^#Color/Color/g" /etc/pacman.conf

# Set the time
sudo timedatectl set-timezone America/New_York 
sudo hwclock --systohc
