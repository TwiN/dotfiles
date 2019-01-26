#!/bin/bash

if ![ -x "$(command -v yay)" ]; then
  echo 'You must install yay to run this script' >&2
  exit 1
fi

echo -e "\e[32m> Installing xorg and xorg-xinit\e[0m"
sudo pacman -Sy --needed xorg xorg-xinit

echo -e "\e[32m> Installing i3-gaps\e[0m"
sudo pacman -S --needed i3-gaps

echo -e "\e[32m> Installing rofi\e[0m"
sudo pacman -S --needed rofi

echo -e "\e[32m> Installing polybar\e[0m"
yay -S --needed polybar

echo -e "\e[32m> Installing compton\e[0m"
sudo pacman -S --needed compton
