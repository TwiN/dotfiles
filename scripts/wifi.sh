#!/bin/bash
# This is intended to temporarily fix the wifi before graphics are available

confirm() {
    read -r -p "${1:-Are you sure?} [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

iw dev
rfkill unblock all

if confirm "Would you like to use wifi-menu?"; then
    sudo wifi-menu
else 
    sudo ip link set wlp107s0 up
    wpa_supplicant -i wlp107s0 -c <(wpa_passphrase "$WIFI_SSID" "$WIFI_PASSWORD") -B
    iw dev wlp107s0 link
    sudo dhcpcd wlp107s0
fi

# When setup done, can use wifi-menu to create a profile followed by:
#netctl enable (name of the profile)
