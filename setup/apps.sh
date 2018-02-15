#!/bin/sh
set -e

fancy_echo "Installing useful Apps"

# install useful desktop apps
pacaur -S --noconfirm --noedit google-chrome dropbox slack-desktop spotify skypeforlinux-bin insomnia franz-bin wine ttf-vista-fonts wps-office steam-native-runtime inkscape gimp etcher

# Thanks to : Erik Dubois at http://www.erikdubois.be
# https://github.com/erikdubois/Antergosi3

# software from 'normal' repositories
pacaur -S --noconfirm --needed archey3 baobab bleachbit catfish clementine conky curl
pacaur -S --noconfirm --needed darktable dconf-editor
pacaur -S --noconfirm --needed dmidecode
pacaur -S --noconfirm --needed evince evolution filezilla firefox
pacaur -S --noconfirm --needed galculator geary gimp git gksu glances gnome-disk-utility
pacaur -S --noconfirm --needed gnome-font-viewer gnome-screenshot gnome-system-monitor gnome-terminal gnome-tweak-tool
pacaur -S --noconfirm --needed gparted gpick grsync
pacaur -S --noconfirm --needed hardinfo hddtemp hexchat htop
pacaur -S --noconfirm --needed inkscape inxi lm_sensors lsb-release meld mlocate mpv
pacaur -S --noconfirm --needed nemo net-tools notify-osd numlockx openshot pinta plank polkit-gnome
pacaur -S --noconfirm --needed redshift ristretto sane screenfetch scrot shotwell
pacaur -S --noconfirm --needed simple-scan simplescreenrecorder smplayer sysstat
pacaur -S --noconfirm --needed terminator thunar transmission-cli transmission-gtk tumbler
pacaur -S --noconfirm --needed variety vlc vnstat wget unclutter

sudo systemctl enable vnstat
sudo systemctl start vnstat

# installation of zippers and unzippers
pacaur -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller

