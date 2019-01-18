#!/bin/bash

###########################################################
# WARNING: This is not intended to be reused by others!   #
# This is tailored specifically for the Yoga Y930         #
# This should be run from a USB key containing arch       #
# Wifi should be working at this point (see wifi.sh)      #
###########################################################

echo -e "\e[92m> Mounting main partition to /mnt\e[0m"
mount /dev/nvme0n1p2 /mnt

echo -e "\e[92m> Clearing main partition\e[0m"
rm -rf /mnt/*

echo -e "\e[92m> Mounting boot partition to /mnt/boot\e[0m"
mount /dev/nvme0n1p1 /mnt/boot

echo -e "\e[92m> Downloading and installing Arch Linux\e[0m"
pacstrap /mnt base vim iw wget git dialog wpa_supplicant

echo -e "\e[92m> If there's anything else you want to install, install it now. When you're done, type exit and reboot\e[0m"
arch-chroot /mnt
