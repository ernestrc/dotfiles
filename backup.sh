#TODO Function that checks if folder dotfiles exists in computer, if it doesnt. It creates it.
echo "Starting dotfiles backup"
cp $HOME/.zshrc $PWD/zshrc
cp -rf $HOME/.oh-my-zsh $PWD/oh-my-zsh
echo "Finished ZSH backup"
cp -rf $HOME/.vim $PWD/vim
echo "Finished VIM backup"
cd $PWD
git add --all .
git commit -m "Backup through script"
git push origin master
echo "Saved dotfiles on git@github.com:ernestrc/room.git"
