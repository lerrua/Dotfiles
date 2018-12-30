#!/bin/sh
yay -S --noconfirm gtk-engine-murrine gtk-engines

[ -d ~/.themes ] && echo "Directory 'themes' already exists" || mkdir -p ~/.themes
cd ~/.themes && git clone https://github.com/paullinuxthemer/Telinkrin-GTK.git
ln -s ~/.themes/Telinkrin-GTK/Telinkrin-Buttons-Left=\>3.30 ~/.themes/Telinkrin-Buttons-Right=\>3.30
