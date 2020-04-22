#!/bin/bash
set -e

sudo pacman -Sy --needed yubioath-desktop
sudo systemctl enable pcscd.service

