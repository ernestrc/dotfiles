ln -s ~/.dotfiles/nvim ~/.config/

if type "clang-format" &> /dev/null ; then
  echo 'clang-format already installed!'
else
  echo 'please install clang-format for vim-autoformat!'
fi
