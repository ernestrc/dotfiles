
let g:neocomplcache_enable_at_startup = 1
let macvim_skip_colorscheme=1

map <Tab> :NERDTreeToggle<CR>
set foldmethod=indent
set foldlevel=99
syntax on                           " syntax highlighing
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
