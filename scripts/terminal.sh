#!/bin/sh
set -e

echo "----------- NVIM -----------"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
echo "Remember ':CocInstall coc-pyls coc-rls coc-highlight coc-emmet' to run coc.nvim bundle."
echo "NeoVim and vim-plug installed."

echo "----------- base16-shell -----------"
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo chsh -s /usr/bin/zsh

echo "----------- ZSH -----------"
echo "Now type \`sudo chsh -s $(which zsh)\` to zsh becomes default."
echo "Logout and login to effective your changes."
