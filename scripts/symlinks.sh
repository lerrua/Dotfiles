#!/bin/sh
set -e

echo "----------- Symlinking -----------"

# zsh
# TODO: Add message after installed to install oh-my-zsh
# install oh-my-zsh and overwrite zsh file
[ -d ~/.config ] && echo "Directory 'config' exists" || mkdir -p ~/.config
ln -s $DOTFILES/config/zsh/zshrc $HOME/.zshrc

# neovim
[ -d ~/.config/nvim ] && echo "Directory 'config' exists" || mkdir -p ~/.config/nvim
ln -s $DOTFILES/config/nvim/init.vim $HOME/.config/nvim/init.vim
ln -s $DOTFILES/config/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json

# tmux
ln -s $DOTFILES/config/tmux/tmux.conf $HOME/.tmux.conf
# ln -s $DOTFILES/config/tmux/tmux.conf.local $HOME/.tmux.conf.local
# ln -s $DOTFILES/config/tmux/tmux.conf.local.server $HOME/.tmux.conf.local
