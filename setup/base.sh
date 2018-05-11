#!/bin/sh
# antergos base config
echo "Installing base-dev libs"
sudo pacman -Syu --noconfirm base-devel
sudo pacman -Syu --noconfirm git vim

# install pacaur
echo "Using Pacaur as Arch package manager"
sudo pacman -Syu --noconfirm pacaur

# in case pure Arch read about how install pacaur: https://www.ostechnix.com/install-pacaur-arch-linux/
# https://gist.github.com/Tadly/0e65d30f279a34c33e9b
# git clone https://aur.archlinux.org/cower.git && cd cower && makepkg -i && cd -
# git clone https://aur.archlinux.org/pacaur.git && cd pacaur && makepkg -i && cd -
