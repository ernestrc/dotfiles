RUN ->  git clone git@github.com:ernestrc/dotfiles.git ~/.dotfiles

IF PERMISSION DENIED, RUN ->

 ssh-keygen -t rsa -C "your email"
 eval `ssh-agent -s`
 ssh-add ~/.ssh/id_rsa
 
COPY CONTENTS OF ~/.ssh/id_rsa.pub TO YOUR GITHUB
 
 git clone git@github.com:ernestrc/dotfiles.git ~/.dotfiles
 
ONCE INSTALLED, DEPLOY ->

 sh ~/.dotfiles/deploy.sh
 
 
NOTE: Used https://github.com/amix/vimrc for Vim configuration and https://github.com/robbyrussell/oh-my-zsh for ZSH

 To install new plugins: git clone git://{ path to plugin }.git sources_non_forked/{ plugin }

