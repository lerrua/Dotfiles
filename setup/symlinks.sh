#!/bin/sh
set -e

fancy_echo "Symlinking dotfiles"

# zsh
# install oh-my-zsh and overwrite zsh file
ln -s $DOTFILES/config/zsh/zshrc $HOME/.zshrc

# neovim
# create .config folder and nvim folder
ln -s $DOTFILES/config/neovim/init.vim $HOME/.config/nvim/init.vim
ln -s $DOTFILES/config/neovim/local_init.vim $HOME/.config/nvim/local_init.vim
ln -s $DOTFILES/config/neovim/local_bundles.vim $HOME/.config/nvim/local_bundles.vim

# tmux
ln -s $DOTFILES/config/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/config/tmux/tmux.conf.local $HOME/.tmux.conf.local
