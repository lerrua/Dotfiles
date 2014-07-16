## Installation instructions
#### Dependencies

* Python Flake8
```
sudo pip install flake8
```

* Linux
```
apt-get install exuberant-ctags xclip
```

* Mac OSX
```
brew install ctags
```

#### Installation 
#####(recommended!)

```
curl https://raw.github.com/lerrua/vimfiles/master/bootstrap.sh -o - | sh
```

#### Manual Installation


```
git clone https://github.com/lerrua/vimfiles.git ~/.vim/
ln -s ~/.vim/vimrc ~/.vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
```

## Commads

* Window navigation

```Ctrl-w-Up``` = Go to up buffer window

```Ctrl-w-Down``` = Go to down buffer window

```Ctrl-w-Left``` = Go to left buffer window

```Ctrl-w-Right``` = Go to right buffer window


* Open files

```Ctrl-t``` = Open files in project

```Ctrl-b``` = Open buffers files

```Ctrl-N``` = Toggle tree

```F2``` = Open tree by actual file

* Autocomplete and file navigation

```Ctrl-Space``` = Autocomplete

```F4``` = Toggle Tagbar class/methods list

```F3``` = Maximize window buffer

```,f``` = Call grep search

```,g``` = Go to definition by word on cursor (function, method, class)


## Helpful Cheat Sheet commands

http://csnipp.com/go_on/69


## Learn Vim

Visit the following sites to learn more about Vim:

* http://www.vimcasts.org
* http://www.openvim.com
