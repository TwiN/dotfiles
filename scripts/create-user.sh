#!/bin/bash

echo -e "\e[32m> Creating user 'twin' in group 'wheel'\e[0m"
useradd -m -G wheel -s /bin/bash twin

if ! [ -x "$(command -v sudo)" ]; then
    echo -e "\e[32m> Installing sudo\e[0m"
    pacman -Sy sudo
fi

echo -e "\e[32m> Adding wheel group to sudoers\e[0m"
echo "%wheel ALL=(ALL) ALL" | sudo tee -a /etc/sudoers >> /dev/null

passwd twin
