#!/bin/bash
echo -e "\e[32mInstalling some necessary packages\e[0m"
sudo pacman -Sy vim base-devel go firefox-developer-edition mlocate wpa_supplicant iw

echo -e "\e[32mUpdating mlocate's database (use locate to search for a file)\e[0m"
sudo updatedb

echo -e "\e[32mInstalling yay as AUR helper\e[0m"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
echo "Cleaning up"
rm -rf yay
