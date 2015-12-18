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

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        nnoremap ∆ <c-w>j
        nnoremap ˚ <c-w>k
        nnoremap ¬ <c-w>l
        nnoremap ˙ <c-w>h
    else
        nnoremap ê <c-w>j
        nnoremap ë <c-w>k
        nnoremap ì <c-w>l
        nnoremap è <c-w>h
    endif
endif

nnoremap ,v <C-w>v
nnoremap ,h <C-w>s
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bn<CR>
nnoremap <C-a> :bufdo Bclose<CR>

set number
noremap <C-b> :Autoformat<CR><CR>

let g:solarized_termcolors=256
set background=dark

colo desert

" size of a hard tabstop
set tabstop=4

set exrc
set secure

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
"
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

autocmd FileType scala inoremap gd <c-]>
set tags=./tags,tags,../tags

let g:ctrlp_custom_ignore ='target\|node_modules\|^\.DS_Store\|^\.git\|^\.coffee|^.class'

let g:rustc_pat = "/usr/local/bin/rustc"
autocmd FileType rust nnoremap <CR> :exe 'w' <bar> !RUST_BACKTRACE=1 cargo build<cr>
autocmd FileType rust nnoremap <D-CR> :exe 'w' <bar> !RUST_BACKTRACE=1 cargo run<cr>
autocmd FileType rust nnoremap <c-CR> :exe 'w' <bar> !RUST_BACKTRACE=1 cargo test<cr>

let g:racer_cmd = "/usr/local/src/racer/target/release/racer"
let $RUST_SRC_PATH="/usr/local/src/rust/src"
let g:rust_recommended_style = 1

set copyindent
set history=1000
set undolevels=1000
set wildignore+=*.swp,*.bak,*.pyc,*.class
set shiftwidth=4
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set visualbell
"set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile

nnoremap <C-y> :YRShow<CR>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:yankring_replace_n_pkey = '<C-I-O>'

set clipboard+=unnamed
set clipboard+=unnamedplus
set go+=a " Visual selection automatically copied to the clipboard

highlight LineNr ctermfg=darkgrey ctermbg=None

"use current tab to open new buffers
set switchbuf=usetab

"GO
au FileType go nmap <CR> <Plug>(go-run)
au FileType go nmap <D-CR> <Plug>(go-build)
au FileType go nmap <S-CR> <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap gdh <Plug>(go-def-split)
au FileType go nmap gdv <Plug>(go-def-vertical)
au FileType go nmap gd :GoDef<CR>
au FileType go nmap gdt <Plug>(go-def-tab)
au FileType go nmap <C-gdh> <Plug>(go-doc)
au FileType go nmap <C-gd> <Plug>(go-doc-vertical)
au FileType go nmap <C-gdb> <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
set nofoldenable
