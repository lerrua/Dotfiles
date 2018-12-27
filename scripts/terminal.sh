#!/bin/sh
set -e

echo "Installing gnome-terminal"

yay -S --noconfirm --needed gnome-terminal

echo "Installing Vim-Plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing base16-shell"
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo chsh -s /usr/bin/zsh

echo "----------- ZSH -----------"
echo "Now type \`sudo chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."
