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
nnoremap ∆ <c-w>j
nnoremap ˚ <c-w>k
nnoremap ¬ <c-w>l
nnoremap ˙ <c-w>h
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

nnoremap <C-h> :blast<CR>
nnoremap <C-l> :bn<CR>

nnoremap <C-a> :bufdo bdelete<CR>

set number
noremap <C-b> :Autoformat<CR><CR>

let g:solarized_termcolors=256
set background=dark
colo solarized

" size of a hard tabstop
set tabstop=4

set exrc
set secure

" size of an "indent"
set shiftwidth=4

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab

let g:ycm_global_ycm_extra_conf = "~/.dotfiles/ycm_extra_conf.py"
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

set hidden
let g:racer_cmd = "~/.dotfiles/sources_forked/rust-racer/target/release/racer"
let $RUST_SRC_PATH="/usr/local/src/rust/src"

autocmd FileType cpp noremap <ENTER> :make!<cr>
autocmd FileType rust nnoremap <ENTER> :exe 'w' <bar> !cargo build<cr>
autocmd FileType scala nnoremap <ENTER> :exe 'w' <bar> !sbt compile<cr>
inoremap <C-@> <C-x><C-o>
inoremap <C-SPACE> <C-x><C-o>
noremap <C-w> :bd<cr>
