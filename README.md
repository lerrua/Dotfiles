# Dotfiles

## VIM Distribution

Base vimrc is [vim-bootstrap](http://vim-bootstrap.com)

```
curl 'http://vim-bootstrap.com/generate.vim' --data 'langs=go&langs=lua&langs=javascript&langs=python&langs=html&langs=ruby&editor=vim' > ~/.vimrc
```

### Local configuration

* vimrc.local
* vimrc.local.bundle

### Dependencies

* Powerline fonts

Linux

```
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf
```

OSX
```
cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf
```

* Extra fonts

```
git clone git@github.com:ryanoasis/nerd-fonts.git
./install.sh
```
