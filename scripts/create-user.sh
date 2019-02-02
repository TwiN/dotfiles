#!/bin/bash

echo -e "\e[32m> Creating user 'twin' in group 'wheel'\e[0m"
useradd -m -G wheel -s /bin/bash twin

if ! [ -x "$(command -v sudo)" ]; then
    echo -e "\e[32m> Installing sudo\e[0m"
    pacman -Sy sudo
fi

passwd twin

echo -e "\e[32m> Type 'sudo visudo' and add/uncomment the following:\e[0m"
echo "%wheel ALL=(ALL) ALL" 

echo -e "\e[32m> To keep the user's home directory when using sudo, type 'sudo visudo' and add/uncomment the following line:\e[0m"
echo "Defaults env_keep += \"HOME\""

