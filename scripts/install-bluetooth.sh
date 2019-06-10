#!/bin/bash

# This needs some work, I'm lazy right now so...

sudo pacman -Sy bluez bluez-utils

# Should we really enable it out of the box? Waste of power
#sudo systemctl enable bluetooth 

# Bluetooth audio
sudo pacman -S --needed pulseaudio-bluetooth

