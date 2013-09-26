## Dependencies


Flake8
```
sudo pip install flake8
```


Linux
```
apt-get install exuberant-ctags xclip vim-gnome
```

Mac OSX
```
brew install ctags
```

## Installation 
#####(recommended)


```
curl https://raw.github.com/lerrua/vimfiles/master/bootstrap.sh -o - | sh
```


## Manual Installation


```
git clone https://github.com/lerrua/vimfiles.git ~/.vim/
ln -s ~/.vim/vimrc ~/.vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
```
