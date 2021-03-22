#!/bin/sh

source $DOTFILES/scripts/git.sh

sudo apt install neovim python3-neovim

# zsh
sudo apt install zsh
sudo chsh -s /usr/bin/zsh
echo "Now type \`sudo chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# dev utilities
sudo apt install golang fzf htop bat tig tree exa silversearcher-ag prettyping ranger ripgrep make zsh inotify-tools tmux libssl-dev dirmngr gpg gnome-shell-pomodoro

# golang utilities
go get github.com/gsamokovarov/jump
go get github.com/sosedoff/pgweb

# flatpak
sudo apt install flatpak

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
asdf update --head
asdf plugin add ruby
asdf install ruby 2.7.1
asdf global ruby 2.7.1

asdf plugin add nodejs
asdf install nodejs 14.15.1
asdf global nodejs 14.15.1

asdf plugin add python
asdf install python 3.9.1
asdf global python 3.9.1

# neovim on asdf
pip install pynvim

source $DOTFILES/scripts/fonts.sh
source $DOTFILES/scripts/symlinks.sh
source $DOTFILES/scripts/terminal.sh
