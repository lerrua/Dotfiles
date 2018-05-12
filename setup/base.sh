#!/bin/sh
# Antergos base config
echo "Installing base-dev libs"
sudo pacman -Syu --noconfirm base-devel git vim

# in case pure Arch read about how install pacaur: https://www.ostechnix.com/install-pacaur-arch-linux/
# install pacaur
echo "Using Pacaur as Arch package manager"
sudo pacman -Syu --noconfirm pacaur


# https://gist.github.com/Tadly/0e65d30f279a34c33e9b
# git clone https://aur.archlinux.org/cower.git && cd cower && makepkg -i && cd -
# git clone https://aur.archlinux.org/pacaur.git && cd pacaur && makepkg -i && cd -

# in case antergos minimal, changing login screen to gdm as default
sudo pacman -S gdm
sudo systemctl -f enable gdm

# battery save
pacman -S tlp
systemctl enable tlp.service
