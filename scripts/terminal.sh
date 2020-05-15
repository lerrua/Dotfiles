#!/bin/sh
set -e

echo "----------- NVIM -----------"
vim +PlugInstall +qall

echo "NeoVim and vim-plug installed."

echo "----------- base16-shell -----------"
# TODO: Check if path exists before pull
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# VIM TIP: paste unicode icons on vim:
# i Ctrl+v u2713 .
# https://x-team.com/blog/inserting-unicode-characters-in-vim/

# VIM TIP: show vim colors
# :so $VIMRUNTIME/syntax/hitest.vim
