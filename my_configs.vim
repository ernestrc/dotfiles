map <Tab> :NERDTreeToggle<CR>
set foldmethod=indent
set foldlevel=99
syntax on                           " syntax highlighing
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

let g:NERDTreeWinSize=40
let g:gitgutter_enabled = 1
set paste
map ∆ <c-w>j
map ˚ <c-w>k
map ¬ <c-w>l
map ˙ <c-w>h
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

nnoremap <C-h> :blast<CR>
nnoremap <C-l> :bn<CR>

nnoremap <C-a> :bufdo bdelete<CR>

set number
noremap <C-b> :Autoformat<CR><CR>

colo dracula

" size of a hard tabstop
set tabstop=4

" size of an "indent"
set shiftwidth=4

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab
