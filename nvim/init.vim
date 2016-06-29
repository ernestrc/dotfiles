

" PLUGINS

call plug#begin()
"Plug 'derekwyatt/vim-scala'
"Plug 'git@github.com:scrooloose/syntastic.git'
Plug 'tpope/vim-sensible'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'git@github.com:rbgrouleff/bclose.vim.git'
Plug 'Chiel92/vim-autoformat'
Plug 'mhinz/vim-signify'
Plug 'rust-lang/rust.vim'
Plug 'mhartington/oceanic-next'
Plug 'junegunn/fzf', { 'dir': '~/.zplug/repos/junegunn/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'racer-rust/vim-racer'

Plug 'critiqjo/lldb.nvim'
Plug 'neomake/neomake'
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
call plug#end()


" SETTINGS

set foldmethod=indent
set foldlevel=99
syntax enable
filetype on
filetype plugin indent on
set number
colorscheme OceanicNext
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
set exrc
set encoding=utf8
set secure
set hidden
set tabstop=4
set softtabstop=4
set smarttab
set expandtab
set copyindent
set history=1000
set undolevels=1000
set wildignore+=*.swp,*.bak,*.pyc,*.class
set shiftwidth=2
set scrolloff=3
set autoindent
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile
highlight LineNr ctermfg=darkgrey ctermbg=None
set clipboard+=unnamed
set clipboard+=unnamedplus
set go+=a
set switchbuf=usetab
set nofoldenable
set nowrap


" MAPPINGS

nnoremap <M-j> <c-w>j
nnoremap <M-k> <c-w>k
nnoremap <M-l> <c-w>l
nnoremap <M-h> <c-w>h
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bn<CR>
nnoremap <C-a> :bufdo bd<CR>
inoremap <C-@> <C-x><C-o>
inoremap <C-SPACE> <C-x><C-o>
noremap <space> @q
nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
nnoremap <silent> <C-w> :lclose<CR>:Bclose<CR>


" PLUGIN SETTINGS

let g:rustc_syntax_only = 0
let g:rust_recommended_style = 1
let g:racer_cmd = "/usr/local/src/racer/target/release/racer"
let $RUST_SRC_PATH="/usr/local/src/rustc-nightly/src"
let $RUST_BACKTRACE=0
let $RUST_LOG="error"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers=['pyflakes']

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']

let g:NERDTreeWinSize=30

let g:gitgutter_enabled = 1

let g:yankring_replace_n_pkey = '<C-I-O>'

let g:deoplete#enable_at_startup = 1

set tags=./tags,tags,../tags

let errorformat  =
      \ '%E%f:%l:%c: %\d%#:%\d%# %.%\{-}error:%.%\{-} %m,'   .
      \ '%W%f:%l:%c: %\d%#:%\d%# %.%\{-}warning:%.%\{-} %m,' .
      \ '%C%f:%l %m,' .
      \ '%-Z%.%#'

let g:neomake_rust_bcargo_maker = {
      \ 'exe': 'cargo',
      \ 'args' : ['build'],
      \ 'append_file': 0,
      \ 'errorformat': errorformat
      \ }

let g:neomake_rust_enabled_makers = ['bcargo']
let g:neomake_logfile ="/var/log/neomake.log"
autocmd! BufWritePost * Neomake


" PLUGIN MAPPINGS

nnoremap <C-p> :Files<CR>
noremap <C-b> :Autoformat<CR><CR>
nnoremap <C-y> :YRShow<CR>
nmap gd :YcmCompleter GoTo<CR>
map <Tab> :NERDTreeToggle<CR>
