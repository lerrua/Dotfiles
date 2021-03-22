#!/bin/sh

echo "Get nerdfonts at https://github.com/ryanoasis/nerd-fonts"
[ -d ~/.local/share/fonts ] && echo "Directory '.local/share/fonts' exists" || mkdir -p ~/.local/share/fonts

# Droid Sans
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.otf

# Knack Regular
cd ~/.local/share/fonts && curl -fLo "Knack Regular Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf

curl https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip

fc-cache -v
