#!/bin/sh
set -e

echo "Symlinking dotfiles"

# zsh
# install oh-my-zsh and overwrite zsh file
ln -s $DOTFILES/config/zsh/zshrc $HOME/.zshrc

# neovim
# create .config folder and nvim folder
ln -s $DOTFILES/config/nvim/init.vim $HOME/.config/nvim/init.vim

# tmux
ln -s $DOTFILES/config/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/config/tmux/tmux.conf.local $HOME/.tmux.conf.local
# ln -s $DOTFILES/config/tmux/tmux.conf.local.server $HOME/.tmux.conf.local
