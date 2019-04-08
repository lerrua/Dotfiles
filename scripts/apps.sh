#!/bin/sh
set -e

echo "----------- APPS -----------"

# install useful apps
_installMany google-chrome dropbox slack-desktop spotify wps-office steam-native-runtime
_installMany inkscape gimp etcher telegram-desktop dconf-editor filezilla firefox glances chrome-gnome-shell 
_installMany gparted gpick grsync hexchat inkscape redshift pgweb-bin simplescreenrecrder transmission-cli transmission-gtk
_installMany vlc vnstat unclutter tlp nordvpn-bin unace unrar zip unzip sharutils uudeview arj cabextract file-roller

# enable services
# TODO: ask to enable services
sudo systemctl enable tlp.service
sudo systemctl enable vnstat
sudo systemctl start vnstat
sudo systemctl enable docker
sudo systemctl enable --now nordvpnd
