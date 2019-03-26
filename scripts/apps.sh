#!/bin/sh
set -e

echo "----------- APPS -----------"

# install useful apps
_installMany google-chrome dropbox slack-desktop spotify 
_installMany wps-office steam-native-runtime
_installMany inkscape gimp etcher telegram-desktop
_installMany archey3 bleachbit curl dconf-editor jump
_installMany filezilla firefox git glances 
_installMany gnome-font-viewer gnome-screenshot
_installMany gparted gpick grsync hddtemp hexchat htop
_installMany inkscape mlocate redshift screenfetch 
_installMany simplescreenrecorder transmission-cli transmission-gtk
_installMany vlc vnstat unclutter tlp nordvpn-bin
_installMany unace unrar zip unzip sharutils uudeview arj cabextract file-roller

# enable services
sudo systemctl enable tlp.service
sudo systemctl enable vnstat
sudo systemctl start vnstat
sudo systemctl enable docker
sudo systemctl enable --now nordvpnd
