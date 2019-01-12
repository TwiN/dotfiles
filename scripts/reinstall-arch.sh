#!/bin/bash

###########################################################
# WARNING: This is not intended to be reused by others!   #
# This is tailored specifically for the Yoga Y930         #
# This should be run from a USB key containing arch       #
# Wifi should be working at this point (see wifi.sh)      #
###########################################################

pacman -Sy vim
mount /dev/nvme0n1p2 /mnt
rm -rf /mnt/*
pacstrap /mnt
mount /dev/nvme0n1p1 /mnt/boot

arch-chroot /mnt
pacman -Sy vim iw wget git dialog wpa_supplicant

echo "If there's anything else you want to install, install it now. When you're done, type exit and reboot"
