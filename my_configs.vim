
map <Tab> :NERDTreeToggle<CR>
set foldmethod=indent
set foldlevel=99
syntax on                           " syntax highlighing
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set paste
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set relativenumber
