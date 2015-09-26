if [ -d "$HOME/.config/awesome" ]; then
    ln -s $HOME/.dotfiles/arch/awesome.lua $HOME/.config/awesome/rc.lua
fi
