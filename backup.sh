#TODO Function that checks if folder dotfiles exists in computer, if it doesnt. It creates it.
echo "Starting dotfiles backup"
cp $HOME/.zshrc $PWD/zshrc/.zshrc
git add --all .
git commit -m "Backup through script"
git push origin master
echo "Saved dotfiles on git@github.com:ernestrc/room.git"
