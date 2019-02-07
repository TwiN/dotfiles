#!/bin/bash
set -e # Exit if any command fails

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
    
    echo -e "\e[32m> Installing necessary packages\e[0m"
    sudo pacman -Sy --needed python python-pip vim go mlocate wpa_supplicant iw git wget dialog screenfetch htop rxvt-unicode xterm alsa-utils unzip cmake

    echo -e "\e[32m> Updating mlocate's database (use locate to search for a file)\e[0m"
    sudo updatedb
fi

if confirm "Install yay as AUR helper?"; then
    echo -e "\e[32m> Installing yay as AUR helper\e[0m"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    echo e "\e[32m> Cleaning up\e[0m"
    rm -rf yay
    confirm "Install urxvt plugins?" && yay -S urxvt-resize-font-git
    confirm "Install glyph fonts?" && yay -S siji-git ttf-font-awesome-4 ttf-material-icons termsyn-font
fi

if confirm "Install acpi to view your battery status?"; then
    echo -e "\e[32m> Installing acpi\e[0m"
    sudo pacman -Sy --needed acpi
fi

confirm "Install openjdk?" && sudo pacman -Sy --needed jdk-openjdk
confirm "Install firefox-developer-edition?" && sudo pacman -Sy --needed firefox-developer-edition
confirm "Install aws-cli?" && sudo pacman -Sy --needed aws-cli
confirm "Install fonts?" && sudo pacman -Sy --needed ttf-hack ttf-inconsolata ttf-dejavu terminus-font ttf-freefont xorg-xfd
confirm "Install feh (Image viewer and desktop wallpaper manager)?" && sudo pacman -Sy --needed feh
confirm "Install ranger?" && sudo pacman -Sy --needed ranger


#########################
# Dotfiles/Config files #
#########################

if confirm "Copy dotfiles to home directory?"; then
	cp ../.vimrc ~
	cp ../.bashrc ~
	cp ../.Xdefaults ~
	cp ../.profile ~
	cp ../.xinitrc ~
	cp -R ../.vim ~
	cp -R ../.config ~
fi

if confirm "Copy etc files and directories to /etc?"; then
	sudo cp -R ../etc /etc
fi


#######################
# Sauce Code Pro Font #
#######################

if confirm "Install Sauce Code Pro font (glyphs and icons)?"; then
	echo -e "\e[32m> Creating font directory\e[0m"
	mkdir -p sauce-code-pro
	cd sauce-code-pro
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/SourceCodePro.zip 
	unzip SourceCodePro.zip
	chmod --recursive 0755 .
	rm -rf *Windows* SourceCodePro.zip
	mkfontscale
	mkfontdir
	cd ..
	echo -e "\e[32m> Moving sauce-code-pro font directory to /usr/share/fonts\e[0m"
	sudo cp -rf sauce-code-pro /usr/share/fonts/
	echo -e "\e[32m> Cleaning up\e[0m"
	rm -rf sauce-code-pro
fi


###############
# Vim plugins #
###############

if confirm "Install and compile vim plugins?"; then
	echo -e "\e[32m> Installing vim plugins (if necessary)\e[0m"
	vim +'PlugInstall' +qa
	echo -e "\e[32m> Compiling YouCompleteMe\e[0m"
	sudo python ~/.vim/plugged/YouCompleteMe/install.py --go-completer
fi


########
# MISC #
########

# Enable colors for pacman 
sudo sed -i "s/^#Color/Color/g" /etc/pacman.conf

# Enable en_US.UTF-8 locale
sudo sed -i "s/^#en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen
sudo locale-gen

# Set the time
sudo timedatectl set-timezone America/New_York 
sudo hwclock --systohc
