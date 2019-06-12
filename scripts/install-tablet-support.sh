#!/bin/bash
set -e # Exit if any command fails

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

if ! [ -x "$(command -v yay)" ]; then
  echo 'You must install yay to run this script' >&2
  exit 1
fi

confirm "Install iio-sensor-proxy (needed for ~/.config/i3/auto-screen-rotate.sh)?" && yay -Sy --needed iio-sensor-proxy-git
confirm "Install xf86-input-wacom and libwacom?" && sudo pacman -Syu --needed xf86-input-wacom libwacom
#confirm "Install onboard (on-screen keyboard)?" && sudo pacman -Syu --needed onboard

