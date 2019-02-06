#!/bin/bash

############################################################
# This assumes that you:                                   #
# - Have a SWAP partition on /dev/nvme0n1p3                #
############################################################

device="/dev/nvme0n1p3"

sudo mkswap $device
sudo swapon $device

echo "If the two commands above returned errors about being busy/in use, it's because you already have a swap partition enabled. You can ignore those messages"

# Comment previous directive for HandleLidSwitch, just in case.
sudo sed -i "s/^HandleLidSwitch/#HandleLidSwitch/g" /etc/systemd/logind.conf
# Add new directive for HandleLidSwitch. This will trigger hibernate when you close the lid
echo "HandleLidSwitch=hibernate" | sudo tee -a /etc/systemd/logind.conf >/dev/null

echo "Make sure that you add 'resume' in the list of 'HOOKS' in your /etc/mkinitcpio.conf file. When you added 'resume', type 'sudo 'mkinitpcio -p linux'"
