#!/bin/sh

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_echo "Symlinking dotfiles"

ln -s $DOTFILES/vim/vimrc.local ~/.vimrc.local
ln -s $DOTFILES/vim/vimrc.local.bundles ~/.vimrc.local.bundles

ln -s $DOTFILES/tmux/tmux.conf ~/.tmux.conf
ln -s $DOTFILES/tmux/tmux.powerline ~/.tmux.powerline

ln -s $DOTFILES/bin/tm  /usr/local/bin/tm
