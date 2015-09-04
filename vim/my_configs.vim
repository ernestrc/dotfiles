map <Tab> :NERDTreeToggle<CR>
set foldmethod=indent
set foldlevel=99
syntax on                           " syntax highlighing
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

let g:NERDTreeWinSize=30
let g:gitgutter_enabled = 1
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

nnoremap <C-a> :bufdo Bclose<CR>

set number
noremap <C-b> :Autoformat<CR><CR>

let g:solarized_termcolors=256
set background=dark
colo valloric

" size of a hard tabstop
set tabstop=4

"set exrc
"set secure

" size of an "indent"
set shiftwidth=4

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab

set hidden
"custom fletype color themes
" autocmd FileType rust set background=dark
" autocmd FileType rust colo solarized

" custom filetype mappings
autocmd FileType cpp noremap <CR> :make!<cr>
autocmd FileType scala nnoremap <CR> :exe 'w' <bar> !sbt compile<cr>
autocmd FileType scala nnoremap <D-CR> :exe 'w' <bar> !sbt run<cr>
autocmd FileType scala nnoremap <c-CR> :exe 'w' <bar> !sbt test<cr>
inoremap <C-@> <C-x><C-o>
inoremap <C-SPACE> <C-x><C-o>
noremap <C-w> :Bclose<cr>

set guifont=Menlo Regular:h13
autocmd FileType scala inoremap gd <c-]>
set tags=./tags,tags,../tags

set autoindent
set copyindent
set shiftwidth=4
set history=1000
set undolevels=1000
set wildignore+=*.swp,*.bak,*.pyc,*.class
let g:ctrlp_custom_ignore ='target\|node_modules\|^\.DS_Store\|^\.git\|^\.coffee|^.class'

let g:rustc_pat = "/usr/local/bin/rustc"
autocmd FileType rust nnoremap <CR> :exe 'w' <bar> !cargo build<cr>
autocmd FileType rust nnoremap <D-CR> :exe 'w' <bar> !cargo run<cr>
autocmd FileType rust nnoremap <c-CR> :exe 'w' <bar> !cargo test<cr>
" let g:racer_cmd = "~/.dotfiles/vim/sources_forked/rust-racer/target/release/racer"
" let $RUST_SRC_PATH="/usr/local/src/rust/src"
let g:rust_recommended_style = 1
