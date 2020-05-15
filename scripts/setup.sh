#!/bin/sh

source $DOTFILES/scripts/git.sh

sudo dnf install -y neovim python-devel python3-neovim util-linux-user go nodejs nodejs-yarn dnf-plugins-core

# common utilities
sudo dnf install -y grubby fzf htop bat tig tree exa the_silver_searcher prettyping ranger ripgrep make zsh
go get github.com/gsamokovarov/jump
go get github.com/sosedoff/pgweb

# zsh
sudo chsh -s /usr/bin/zsh
echo "Now type \`sudo chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

source $DOTFILES/scripts/fonts.sh
source $DOTFILES/scripts/symlinks.sh
source $DOTFILES/scripts/terminal.sh
