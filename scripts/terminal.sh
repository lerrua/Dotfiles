#!/bin/sh
set -e

echo "----------- NVIM -----------"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
# TODO: make after messages variable to print at end message
echo "Remember ':CocInstall coc-pyls coc-rls coc-highlight coc-emmet' to run coc.nvim bundle."
echo "NeoVim and vim-plug installed."

echo "----------- base16-shell -----------"
# TODO: Check if path exists before pull
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
