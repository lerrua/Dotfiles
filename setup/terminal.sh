#!/bin/sh

echo "Installing gnome-terminal"

pacaur -S --noconfirm --noedit gnome-terminal

# install gruvbox gnome terminal theme
# http://mayccoll.github.io/Gogh/
wget -O xt https://git.io/v7eBS && chmod +x xt && ./xt && rm xt

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo chsh -s /usr/bin/zsh

echo "----------- ZSH -----------"
echo "Now type \`sudo chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."
