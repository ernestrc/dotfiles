if [ -d "$HOME/.config/awesome" ]; then
    ln -s $HOME/.dotfiles/arch/awesome.lua $HOME/.config/awesome/rc.lua
    cp -R $HOME/.dotfiles/arch/awesome-themes/* /usr/share/awesome/themes/
fi
