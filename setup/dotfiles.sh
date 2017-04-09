#!/bin/sh

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_echo "Symlinking dotfiles"

ln -s ~/Code/github-projects/Dotfiles/vim/vimrc.local ~/.vimrc.local
ln -s ~/Code/github-projects/Dotfiles/vim/vimrc.local.bundles ~/.vimrc.local.bundles

ln -s ~/Code/github-projects/Dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/Code/github-projects/Dotfiles/tmux/tmux.powerline ~/.tmux.powerline
