#!/bin/sh

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_echo "Symlinking dotfiles"

ln -s ~/Code/github-projects/Dotfiles/vimrc.local ~/.vimrc.bundles.local
ln -s ~/Code/github-projects/Dotfiles/vimrc.local.bundles ~/.vimrc.bundles.local.bundles
