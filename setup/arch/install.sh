#!/bin/sh
# Antergos base config

# in case pure Arch read about how install pacaur: https://www.ostechnix.com/install-pacaur-arch-linux/
# install pacaur
sudo pacman -Syu --noconfirm pacaur

sudo pacman -Syu --noconfirm git vim
sudo pacman -Syu --noconfirm base-devel

export EDITOR="vim"

# python and neovim dependencies
sudo pacman -Syu --noconfirm python python-setuptools
sudo easy_install pip
sudo pip install neovim

# install base packages
pacaur -S --noconfirm --noedit ctags ncurses curl unzip neovim go docker docker-compose tmux zsh htop fzf xsel silver-searcher-git tree exa dconf ranger

# install useful apps
pacaur -S --noconfirm --noedit google-chrome dropbox slack-desktop spotify skypeforlinux-bin insomnia franz-bin wine ttf-vista-fonts wps-office steam-native-runtime

# install gruvbox gnome terminal theme
# http://mayccoll.github.io/Gogh/
wget -O xt https://git.io/v7eBS && chmod +x xt && ./xt && rm xt

echo "Now type \`sudo chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."
