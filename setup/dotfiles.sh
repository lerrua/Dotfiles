#!/bin/sh

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_echo "Symlinking dotfiles"

# vimfiles
ln -s $DOTFILES/vim/vimrc.local ~/.vimrc.local
ln -s $DOTFILES/vim/vimrc.local.bundles ~/.vimrc.local.bundles

# tmux
ln -s $DOTFILES/tmux/tmux.conf ~/.tmux.conf
ln -s $DOTFILES/tmux/tmux.conf.local ~/.tmux.conf.local
ln -s $DOTFILES/bin/tm  /usr/local/bin/tm

# bash_it
mkdir -p ~/.bash_it/themes/coffee/
ln -s $DOTFILES/bash/themes/coffee/coffee.theme.bash  ~/.bash_it/themes/coffee/coffee.theme.bash
