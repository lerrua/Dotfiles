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
ln -s $DOTFILES/vim/vimrc.local.bundles ~/.vimrc.local.bundles

# tmux
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/tmux/tmux.conf.local $HOME/.tmux.conf.local
ln -s $DOTFILES/bin/tm  /usr/local/bin/tm
