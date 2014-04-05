#!/bin/sh -e
#This script works in Ubuntu only
LINUX_TYPE="uname -a"
eval $LINUX_TYPE
echo -n "Are you sure you want to deploy so much awesomeness here? [Y/N]?"
read
if [ "$REPLY" = "y" ]; then {
		
	# VIM
	sudo apt-get install vim
	mv $PWD/vim .vim
	cp -R $PWD/.vim $HOME
	ln $HOME/.vim/vimrc $HOME/.vimrc
	source $HOME/.vimrc
}
