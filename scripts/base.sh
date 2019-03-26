#!/bin/sh

echo "Do you want upgrade the OS before continue?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo pacman -Syu; break;;
        No ) break;;
    esac
done

# TODO: ask question to check base-dev, yay and about lightdm to gdm
echo "Installing base-dev libs"
sudo pacman -S --noconfirm base-devel
sudo pacman -S --noconfirm git vim gdm

echo "Installing Arch package manager alternative"
sudo pacman -S --noconfirm yay

echo "Changing lightdm to gdm"
sudo systemctl disable lightdm
sudo systemctl -f enable gdm

# yay config
yay --nodiffmenu --save  
