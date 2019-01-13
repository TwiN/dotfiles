#!/bin/bash

echo -e "\e[32m> Installing xorg and xorg-xinit if they aren't already installed\e[0m"
sudo pacman -Sy --needed xorg xorg-xinit

echo -e "\e[32m> Installing i3\e[0m"
sudo pacman -Sy --needed i3

echo -e "\e[32m> Installing dmenu and ranger\e[0m"
sudo pacman -Sy --needed dmenu
