# install pacaur
sudo pacman -Syu --noconfirm pacaur git vim

sudo pacman -Syu --noconfirm base-devel

export EDITOR="vim"

# neovim dependencies
sudo easy_install pip
sudo pip install neovim

# install base packages
pacaur -S --noconfirm --noedit ctags ncurses curl unzip vim neovim google-chrome firefox telegram-desktop-bin go dropbox slack-desktop docker docker-compose
