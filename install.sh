#!/usr/bin/env bash

# TODO: add tmux screen to check if want create a session

export EDITOR='vim'
export DOTFILES=$HOME/Code/github/Dotfiles

# check if Dotfiles was exported before export
# check if Dotfiles folder exists before export
echo "Initializing setup..."
# TODO: make art with my name =p
source scripts/setup.sh
