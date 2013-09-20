echo "Installing Vundle..."
for i in ~/.vim ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv $i $i.old; done
git clone https://github.com/lerrua/vimfiles.git ~/.vim/
ln -s ~/.vim/vimrc ~/.vimrc
echo "Installing Vundle..."
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
echo "Installing Bundles"
vim +BundleInstall +qall
echo "Done! <3"
