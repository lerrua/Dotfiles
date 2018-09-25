#!/bin/sh

echo "Installing gnome-terminal"

pacaur -S --noconfirm --noedit gnome-terminal

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo chsh -s /usr/bin/zsh

echo "----------- ZSH -----------"
echo "Now type \`sudo chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."

echo "Installing base16-shell"
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
