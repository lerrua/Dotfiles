#!/bin/sh
set -e

echo "----------- DEV TOOLS -----------"

# python and neovim dependencies
echo "Setting Python environment"
# TODO: ask to install python env
_installMany python python-setuptools
sudo easy_install pip
# neovim
sudo pip install pynvim
pip install --user --upgrade pynvim
# poetry
curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python
# pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# install base packages
_installMany ctags ncurses curl unzip neovim go docker docker-compose tmux
_installMany zsh git fzf xsel silver-searcher-git tree exa dconf ranger mosh
_installMany tig bat prettyping ncdu wget nodejs htop screenfetch jump bleachbit

echo "Setting Rust environment"
# TODO: ask to install rust env
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup install nightly
rustup component add rls-preview --toolchain nightly

echo "----------- ZSH -----------"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo chsh -s /usr/bin/zsh
echo "Now type \`sudo chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."
