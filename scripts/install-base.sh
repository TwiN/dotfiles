#!/bin/bash
set -e # Exit if any command fails

####################################################################
# Everything in this script has to be almost the minimum required  #
# for the configuration to work as intended. Extras should be      #
# split into different scripts                                     #
####################################################################

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
	sudo pacman -Syu --needed base-devel

	echo -e "\e[32m> Installing necessary packages\e[0m"
	sudo pacman -Syu --needed python python-pip neovim go dep mlocate wpa_supplicant iw git wget dialog screenfetch htop rxvt-unicode xterm pulseaudio alsa-utils unzip cmake lsof xclip ruby

	# Automatically start pulseaudio
	echo -e "\e[32m> Enabling pulseaudio on start\e[0m"
	systemctl --user enable pulseaudio && systemctl --user start pulseaudio

	echo -e "\e[32m> Installing not-so-neccessary packages\e[0m"
	sudo pacman -Syu --needed libevent-dev

	echo -e "\e[32m> Updating mlocate's database (use locate to search for a file)\e[0m"
	sudo updatedb
fi

if confirm "Install docker?"; then
	sudo pacman -Syu --needed docker
	sudo systemctl enable docker.service
fi

if confirm "Install yay as AUR helper?"; then
	echo -e "\e[32m> Installing yay as AUR helper\e[0m"
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	echo e "\e[32m> Cleaning up\e[0m"
	rm -rf yay
	confirm "Install urxvt plugins?" && yay -S --needed urxvt-resize-font-git
	confirm "Install glyph fonts?" && yay -S --needed siji-git ttf-font-awesome-4 ttf-material-icons termsyn-font
	confirm "Install kubectl?" && yay -S --needed kubectl-bin
	confirm "Install doctl-bin?" && yay -S --needed doctl-bin
fi

if confirm "Install acpi to view your battery status?"; then
	echo -e "\e[32m> Installing acpi\e[0m"
	sudo pacman -Syu --needed acpi
fi

confirm "Install openjdk?" && sudo pacman -Syu --needed jdk-openjdk
confirm "Install firefox-developer-edition?" && sudo pacman -Syu --needed firefox-developer-edition
confirm "Install aws-cli?" && sudo pacman -Syu --needed aws-cli
confirm "Install fonts?" && sudo pacman -Syu --needed ttf-hack ttf-inconsolata ttf-dejavu terminus-font gnu-free-fonts xorg-xfd
confirm "Install feh (Image viewer and desktop wallpaper manager)?" && sudo pacman -Syu --needed feh
confirm "Install intel-ucode (stability and security updates for the CPU's microcode)?" && sudo pacman -Syu --needed intel-ucode
confirm "Install vlc (video player + webcam recorder)?" && sudo pacman -Syu --needed vlc


#########################
# Dotfiles/Config files #
#########################

if confirm "Copy dotfiles to home directory?"; then
	cp ../.vimrc ~
	cp ../.bashrc ~
	cp ../.aliases ~
	cp ../.Xdefaults ~
	cp ../.profile ~
	cp ../.xinitrc ~
	cp ../.gitconfig ~
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


##########
# Neovim #
##########

if confirm "Create symbolic link 'vim' pointing to 'nvim'?"; then
	sudo ln -s $(which nvim) /usr/local/bin/vim
fi

if confirm "Install and compile vim plugins?"; then
	echo -e "\e[32m> Installing vim plugins (if necessary)\e[0m"
	vim +'PlugInstall' +qa
	#echo -e "\e[32m> Compiling YouCompleteMe\e[0m"
	#sudo python ~/.vim/plugged/YouCompleteMe/install.py --go-completer
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
# Use date/time set on BIOS
sudo hwclock --hctosys
