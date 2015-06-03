#VIM
file="$HOME/.vimrc"
if [ -e "$file" ]
then
	echo ".vimrc does exist"
else
	touch .vimrc
fi

echo 'set runtimepath+=~/.dotfiles

source $HOME/.dotfiles/vimrcs/basic.vim
source $HOME/.dotfiles/vimrcs/filetypes.vim
source $HOME/.dotfiles/vimrcs/plugins_config.vim
source $HOME/.dotfiles/vimrcs/extended.vim

try
source $HOME/.dotfiles/my_configs.vim
catch
endtry' > $HOME/.vimrc

echo "Installed VIM Succesfully"

#ZSH
sudo apt-get install zsh
cp $HOME/.dotfiles/zshrc/.zshrc $HOME/.zshrc
chsh -s /bin/zsh

echo "Installed ZSH Succesfully"
