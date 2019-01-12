#!/bin/bash
# This is intended to temporarily fix the wifi before graphics are available
iw dev
rfkill unblock all
sudo ip link set wlp107s0 up
wpa_supplicant -i wlp107s0 -c <(wpa_passphrase "$WIFI_SSID" "$WIFI_PASSWORD") -B
iw dev wlp107s0 link
sudo dhcpcd wlp107s0

# When setup done, can use wifi-menu followed by:
#netctl enable (name of the profile)
