#!/bin/sh
set -e

echo "Installing lxqt desktop"

pacaur -S --noconfirm --noedit lxqt lxqt-config lxqt-panel lxqt-policykit lxqt-qtplugin lxqt-session lxqt-sudo pcmanfm-qt lxqt-about lxqt-admin lxqt-globalkeys lxqt-notificationd lxqt-openssh-askpass lxqt-powermanagement lxqt-runner qterminal sddm breeze-icons numix-icon-theme numix-circle-icon-theme-git

echo "Enabling sddm"

sudo systemctl enable sddm
