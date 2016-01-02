alias reload!='. ~/.zshrc'
alias grep='grep --color'
alias l='ls -altr'

function clean-steam {
    find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete && \
    find ~/.local/share/Steam/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete && \
    echo 'done cleaning steam'
}

