#!/bin/bash

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

confirm "Install screenrotator?" && yay -Sy --needed iio-sensor-proxy-git screenrotator-git
confirm "Install xf86-input-wacom and libwacom?" && sudo pacman -Sy --needed xf86-input-wacom libwacom

