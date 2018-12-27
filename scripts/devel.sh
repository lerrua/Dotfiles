#!/bin/sh
set -e

echo "Installing tools for developers"

# python and neovim dependencies
sudo pacman -Syu --noconfirm python python-setuptools
sudo easy_install pip
sudo pip install neovim

# install base packages
yay -S --noconfirm --needed ctags ncurses curl unzip neovim go docker docker-compose tmux
yay -S --noconfirm --needed zsh fzf xsel silver-searcher-git tree exa dconf ranger mosh
yay -S --noconfirm --needed tig bat prettyping ncdu

echo "Setting Rust dev environment"

curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup install nightly
rustup component add rls-preview --toolchain nightly
