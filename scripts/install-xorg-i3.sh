#!/bin/bash

if ![ -x "$(command -v yay)" ]; then
  echo 'You must install yay to run this script' >&2
  exit 1
fi

echo -e "\e[32m> Installing xorg and xorg-xinit\e[0m"
sudo pacman -Sy --needed xorg xorg-xinit

echo -e "\e[32m> Installing i3\e[0m"
sudo pacman -Sy --needed i3

echo -e "\e[32m> Installing dmenu\e[0m"
sudo pacman -Sy --needed dmenu

echo -e "\e[32m> Installing polybar\e[0m"
sudo pacman -Sy --needed polybar
