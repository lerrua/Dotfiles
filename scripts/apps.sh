#!/bin/sh
set -e

echo "Installing useful Apps"

# install useful desktop apps
yay -S --noconfirm --needed google-chrome dropbox slack-desktop spotify skypeforlinux-bin
yay -S --noconfirm --needed insomnia franz-bin wine ttf-vista-fonts wps-office steam-native-runtime
yay -S --noconfirm --noneed inkscape gimp etcher telegram-desktop

# software from 'normal' repositories
yay -S --noconfirm --needed archey3 baobab bleachbit catfish clementine conky curl
yay -S --noconfirm --needed darktable dconf-editor
yay -S --noconfirm --needed dmidecode
yay -S --noconfirm --needed evince evolution filezilla firefox
yay -S --noconfirm --needed galculator geary gimp git gksu glances gnome-disk-utility
yay -S --noconfirm --needed gnome-font-viewer gnome-screenshot gnome-system-monitor gnome-terminal gnome-tweak-tool
yay -S --noconfirm --needed gparted gpick grsync
yay -S --noconfirm --needed hardinfo hddtemp hexchat htop
yay -S --noconfirm --needed inkscape inxi lm_sensors lsb-release meld mlocate mpv
yay -S --noconfirm --needed nemo net-tools notify-osd numlockx openshot pinta plank polkit-gnome
yay -S --noconfirm --needed redshift ristretto sane screenfetch scrot shotwell
yay -S --noconfirm --needed simple-scan simplescreenrecorder smplayer sysstat
yay -S --noconfirm --needed thunar transmission-cli transmission-gtk tumbler
yay -S --noconfirm --needed variety vlc vnstat wget unclutter tlp

# installation of zippers and unzippers
yay -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller

sudo systemctl enable tlp.service
sudo systemctl enable vnstat
sudo systemctl start vnstat
