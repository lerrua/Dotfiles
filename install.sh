#!/usr/bin/env bash

export EDITOR='vim'
export DOTFILES=$HOME/Code/github/Dotfiles

# check if Dotfiles was exported before export
# check if Dotfiles folder exists before export
echo "Initializing setup..."
source scripts/setup.sh
