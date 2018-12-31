#!/bin/sh
# antergos base config
echo "Installing base-dev libs"
sudo pacman -Syu --noconfirm base-devel git vim

echo "Installing Arch package manager alternatives"
sudo pacman -Syu --noconfirm pacaur yay

# in case pure Arch read about how install pacaur: https://www.ostechnix.com/install-pacaur-arch-linux/
# https://gist.github.com/Tadly/0e65d30f279a34c33e9b
# git clone https://aur.archlinux.org/cower.git && cd cower && makepkg -i && cd -
# git clone https://aur.archlinux.org/pacaur.git && cd pacaur && makepkg -i && cd -

# change login screen to gdm as default
sudo pacman -S gdm
sudo systemctl disable lightdm
sudo systemctl -f enable gdm

# yay config
yay --nodiffmenu --save  
