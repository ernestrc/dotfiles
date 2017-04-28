# curl -fLo ~/.config/nvim/site/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# ln -s ~/.dotfiles/nvim ~/.config/nvim

if type "clang-format" &> /dev/null ; then
  echo 'clang-format already installed!'
else
  echo 'please install clang-format for vim-autoformat!'
fi
