#!/bin/bash

# This needs some work, I'm lazy right now so...

sudo pacman -Syu --needed bluez bluez-utils

# Should we really enable it out of the box? Waste of power
#sudo systemctl enable bluetooth 

# Bluetooth audio
sudo pacman -Syu --needed pulseaudio-bluetooth

# Automatically start pulseaudio
systemctl --user enable pulseaudio && systemctl --user start pulseaudio

# Connecting to a bluetooth device:
#sudo systemctl restart bluetooth
#bluetoothctl
#power on
#scan on
# If you've never paired with the device, then execute `pair <DEVICE_ID>`
# before connecting to it.
#connect <DEVICE_ID>

# If that doesn't work, execute the following and try the steps above again:
#sudo killall pulseaudio
#pulseaudio --start

