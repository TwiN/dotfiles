#!/bin/bash

###########################################################
# WARNING: This is not intended to be reused by others!   #
# This is tailored specifically for the Yoga Y930         #
# This should be run from a USB key containing arch       #
# Wifi should be working at this point (see wifi.sh)      #
###########################################################

mount /dev/nvme0n1p2 /mnt
rm -rf /mnt/*
mount /dev/nvme0n1p1 /mnt/boot
pacstrap /mnt

# Create a script with the necessary programs to finish the installation
# This is necessary because 'chroot' opens up a new interactive shell in
# the new root, meaning that nothing after the 'arch-chroot /mnt' command
# would run in that new environment; it would run in the old environment
# instead
cat << EOF > /mnt/FINISH_INSTALL.sh
#!/bin/bash
pacman -Sy --needed vim iw wget git dialog wpa_supplicant
echo -e "\e[92mIf there's anything else you want to install, install it now. When you're done, type exit and reboot\e[0m"
rm -- "$0"
EOF

echo -e "\e[92mPlease run 'chmod +x FINISH_INSTALL.sh' followed by './FINISH_INSTALL.sh'\e[0m"
arch-chroot /mnt
