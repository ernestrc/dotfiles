set foldmethod=indent
set foldlevel=99
syntax on                           " syntax highlighing
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype
let g:SuperTabDefaultCompletionType = "context"

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

function! Altmap(char)
  if has('gui_running') | return ' <A-'.a:char.'> ' | else | return ' <Esc>'.a:char.' '|endif
endfunction

if $TERM == 'rxvt-unicode-256color'&&!has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    autocmd InsertEnter * set timeoutlen=0
    autocmd InsertLeave * set timeoutlen=2000
  augroup END
  execute 'nnoremap <silent>'.Altmap('h').'<C-w>h'
  execute 'nnoremap <silent>'.Altmap('k').'<C-w>k'
  execute 'nnoremap <silent>'.Altmap('j').'<C-w>j'
  execute 'nnoremap <silent>'.Altmap('l').'<C-w>l'
endif

nnoremap ,v <C-w>v
nnoremap ,h <C-w>s
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bn<CR>
nnoremap <C-a> :bufdo bd<CR>

set number
noremap <C-b> :Autoformat<CR><CR>

let g:solarized_termcolors=256
set background=dark

colo desert

" size of a hard tabstop
set tabstop=4

set exrc
set secure

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab

set hidden
"
inoremap <C-@> <C-x><C-o>
inoremap <C-SPACE> <C-x><C-o>
noremap <space> @q

set copyindent
set history=1000
set undolevels=1000
set wildignore+=*.swp,*.bak,*.pyc,*.class
set shiftwidth=2
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

set clipboard+=unnamed
set clipboard+=unnamedplus
set go+=a " Visual selection automatically copied to the clipboard

highlight LineNr ctermfg=darkgrey ctermbg=None

"use current tab to open new buffers
set switchbuf=usetab

set nofoldenable

nmap gd :YcmCompleter GoTo<CR>
map <Tab> :NERDTreeToggle<CR>
set nowrap

let g:rustc_syntax_only = 0
nnoremap <silent> <C-w> :lclose<CR>:bdelete<CR>
let g:syntastic_always_populate_loc_list = 1
