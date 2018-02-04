#!/usr/bin/env bash

export EDITOR='vim'
export DOTFILES=$HOME/Code/github/Dotfiles

# check if Dotfiles was exported before export
# check if Dotfiles folder exists before export

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_echo "Initializing setup..."
source setup/setup.sh
