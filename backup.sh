#TODO Function that checks if folder dotfiles exists in computer, if it doesnt. It creates it.
echo "Starting dotfiles backup"
cp $HOME/.zshrc $HOME/dev/dotfiles/dotfiles/
cp -r $HOME/.oh-my-zsh $HOME/dev/dotfiles/dotfiles/
echo "Finished ZSH backup"
cp -r $HOME/.vim $HOME/dev/dotfiles/dotfiles/
echo "Finished VIM backup"
cd $HOME/dev/dotfiles/dotfiles
git add --all .
git commit -m "Backup through script"
git push origin master
echo "Saved dotfiles on git@github.com:ernestrc/room.git"
