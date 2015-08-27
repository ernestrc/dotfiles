#!/bin/sh

#VIM
file="$HOME/.vimrc"
if [ -e "$file" ]
then
	echo ".vimrc does exist"
else
	touch .vimrc
fi

echo 'set runtimepath+=~/.dotfiles

source $HOME/.dotfiles/vim/pathogen.vim
source $HOME/.dotfiles/vim/basic.vim
source $HOME/.dotfiles/vim/filetypes.vim
source $HOME/.dotfiles/vim/plugins_config.vim
source $HOME/.dotfiles/vim/extended.vim

try
source $HOME/.dotfiles/vim/my_configs.vim
catch
endtry' > $HOME/.vimrc

echo "Installed VIM Succesfully"


