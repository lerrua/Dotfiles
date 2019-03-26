#!/bin/sh

echo "----------- Custom Fonts -----------"
_installMany noto-fonts ttf-ubuntu-font-family ttf-droid

echo "export custom xterm font"
tic $DOTFILES/config/tmux/xterm-256color-italic

echo "Get nerdfonts at https://github.com/ryanoasis/nerd-fonts"
[ -d ~/.local/share/fonts ] && echo "Directory '.local/share/fonts' exists" || mkdir -p ~/.local/share/fonts

cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.otf

cd ~/.local/share/fonts && curl -fLo "Knack Regular Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf

fc-cache -v
