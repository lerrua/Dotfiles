#!/bin/sh
# manjaro-gnome base config

# install pacaur
sudo pacman -Syu --noconfirm pacaur git vim

sudo pacman -Syu --noconfirm base-devel

export EDITOR="vim"

# neovim dependencies
sudo easy_install pip
sudo pip install neovim

# install base packages
pacaur -S --noconfirm --noedit ctags ncurses curl unzip vim python-neovim neovim google-chrome firefox go dropbox slack-desktop docker docker-compose tmux zsh htop fzf spotify steam-native steam xsel skypeforlinux-bin insomnia silver-searcher-git tree franz-bin pacaur ttf-vista-fonts

# install useful gnome terminal themes
wget https://raw.githubusercontent.com/romainl/apprentice-colorschemes/master/apprentice_gnome_terminal.sh

echo "Now type \`sudo chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."
