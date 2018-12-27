#!/bin/sh
set -e

echo "Installing useful Apps"

# install useful apps
yay -S --noconfirm --needed google-chrome dropbox slack-desktop spotify 
yay -S --noconfirm --needed wps-office steam-native-runtime
yay -S --noconfirm --needed inkscape gimp etcher telegram-desktop
yay -S --noconfirm --needed archey3 bleachbit curl dconf-editor jump
yay -S --noconfirm --needed filezilla firefox git glances 
yay -S --noconfirm --needed gnome-font-viewer gnome-screenshot
yay -S --noconfirm --needed gparted gpick grsync hddtemp hexchat htop
yay -S --noconfirm --needed inkscape mlocate redshift screenfetch 
yay -S --noconfirm --needed simplescreenrecorder transmission-cli transmission-gtk
yay -S --noconfirm --needed vlc vnstat unclutter tlp

# installation of zippers and unzippers
yay -S --noconfirm --needed unace unrar zip unzip sharutils uudeview arj cabextract file-roller

# enable services
sudo systemctl enable tlp.service
sudo systemctl enable vnstat
sudo systemctl start vnstat
