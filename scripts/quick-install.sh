#!/bin/bash
echo -e "\e[32mInstalling some necessary packages\e[0m"
sudo pacman -Sy vim base-devel go firefox-developer-edition mlocate

echo -e "\e[32mInstalling yay as AUR helper\e[0m"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
echo "Cleaning up"
rm -rf yay
