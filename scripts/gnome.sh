#!/bin/sh
set -e

_installMany gtk-engine-murrine gtk-engines

# gnome base theme
[ -d ~/.themes ] && echo "Directory 'themes' already exists" || mkdir -p ~/.themes
cd ~/.themes && git clone https://github.com/paullinuxthemer/Telinkrin-GTK.git
ln -s ~/.themes/Telinkrin-GTK/Telinkrin-Buttons-Left=\>3.30 ~/.themes/Telinkrin-Buttons-Right=\>3.30

# grub base theme
wget -O - https://github.com/shvchk/poly-dark/raw/master/install.sh | bash
