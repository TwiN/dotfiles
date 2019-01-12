#!/bin/bash

useradd -m -G wheel -s /bin/bash twin

if ! [ -x "$(command -v sudo)" ]; then
    echo -e "\e[32mInstalling sudo\e[0m"
    pacman -Sy sudo
fi

echo -e "\e[32mAdding wheel group to sudoers\e[0m"
echo "%wheel ALL=(ALL) ALL" | sudo tee -a /etc/sudoers >> /dev/null
