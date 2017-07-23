# install pacaur
sudo pacman -Syu --noconfirm pacaur git

# neovim dependencies
easy install pip
sudo pip install neovim

# install base packages
pacaur -S --noconfirm --noedit ctags ncurses curl unzip neovim google-chrome firefox telegram-desktop-bin go dropbox slack docker docker-compose
