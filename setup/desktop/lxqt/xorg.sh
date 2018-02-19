#!/bin/sh
set -e

# Thanks to : Erik Dubois at http://www.erikdubois.be
# https://github.com/erikdubois/Antergosi3

fancy_echo "Goods linux starter"

echo "This is the opensource driver for nvidia"

echo " Xserver setup"

pacaur -S xorg-server xorg-apps xorg-xinit xorg-twm xterm --noconfirm --needed
pacaur -S xf86-video-intel --noconfirm --needed
