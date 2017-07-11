#!/bin/sh

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_echo "Symlinking dotfiles"

# zsh
ln -s $DOTFILES/zsh/zshrc $HOME/.zshrc

# vimfiles
ln -s $DOTFILES/vim/vimrc $HOME/.vimrc
ln -s $DOTFILES/vim/vimrc.local $HOME/.vimrc.local
ln -s $DOTFILES/vim/vimrc.local.bundles $HOME/.vimrc.local.bundles

# neovim
ln -s $DOTFILES/neovim/init.vim $HOME/.config/nvim/init.vim
ln -s $DOTFILES/neovim/local_init.vim $HOME/.config/nvim/local_init.vim
ln -s $DOTFILES/neovim/local_bundles.vim $HOME/.config/nvim/local_bundles.vim

# tmux
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/tmux/tmux.conf.local $HOME/.tmux.conf.local
ln -s $DOTFILES/bin/tm  /usr/local/bin/tm
