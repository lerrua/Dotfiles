#!/bin/sh

fancy_echo "Installing gnome-terminal"

pacaur -S --noconfirm --noedit gnome-terminal

# install gruvbox gnome terminal theme
# http://mayccoll.github.io/Gogh/
wget -O xt https://git.io/v7eBS && chmod +x xt && ./xt && rm xt

echo "----------- ZSH -----------"
echo "Now type \`sudo chsh -s $(which zsh)\` to zsh becomes default."
fancy_echo "Logout and login to effective your changes."
