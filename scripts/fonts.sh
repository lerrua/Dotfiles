#!/bin/sh

echo "Installing fonts"

yay -S noto-fonts --noconfirm --needed
yay -S ttf-ubuntu-font-family --noconfirm --needed
yay -S ttf-droid --noconfirm --noconfirm --needed

tic xterm-256color-italic

echo "Get nerdfonts at https://github.com/ryanoasis/nerd-fonts"

# mkdir -p ~/.local/share/fonts
# cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf

# cd ~/.local/share/fonts && curl -fLo "Knack Regular Nerd Font Complete Mono.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Knack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf

fc-cache -v
