#Function that checks if folder dotfiles exists in computer, if it doesnt. It creates it.
echo "Starting dotfiles backup"
cp $HOME/.zshrc $HOME/dev/dotfiles/dotfiles/
cp $HOME/.oh-my-zsh $HOME/dev/dotfiles/dotfiles/
echo "Finished ZSH backup"
cp $HOME/.vim $HOME/dev/dotfiles/dotfiles/
echo "Finished VIM backup"
cd $HOME/dev/dotfiles/dotfiles
git push origin master
