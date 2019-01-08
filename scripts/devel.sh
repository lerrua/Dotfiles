#!/bin/sh
set -e

echo "Installing tools for developers"

# python and neovim dependencies
echo "Setting Python environment"
_installMany python python-setuptools
sudo easy_install pip
sudo pip install neovim
pip install --user --upgrade pynvim

# install base packages
_installMany ctags ncurses curl unzip neovim go docker docker-compose tmux
_installMany zsh fzf xsel silver-searcher-git tree exa dconf ranger mosh
_installMany tig bat prettyping ncdu wget

echo "Installing Go tools"
go get -v github.com/sosedoff/pgweb 

echo "Setting Rust environment"
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup install nightly
rustup component add rls-preview --toolchain nightly
