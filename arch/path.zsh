[ -n "$XTERM_VERSION" ] && transset-df -a >/dev/null

function awesomerc {
    $EDITOR $HOME/.config/awesome/rc.lua
}
