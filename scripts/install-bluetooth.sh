#!/bin/bash

# This needs some work, I'm lazy right now so...

sudo pacman -Syu bluez bluez-utils

# Should we really enable it out of the box? Waste of power
#sudo systemctl enable bluetooth 

# Bluetooth audio
sudo pacman -Syu --needed pulseaudio-bluetooth

