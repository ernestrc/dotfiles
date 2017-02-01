" PLUGINS

call plug#begin()
"Plug 'derekwyatt/vim-scala'
"Plug 'git@github.com:scrooloose/syntastic.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/rbgrouleff/bclose.vim.git'
Plug 'https://github.com/rking/ag.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-signify'
Plug 'mhartington/oceanic-next'
Plug 'junegunn/fzf', { 'dir': '~/.zplug/repos/junegunn/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips' | Plug 'ernestrc/vim-snippets'
Plug 'fntlnz/atags.vim'

" rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

" js
Plug 'pangloss/vim-javascript' | Plug 'https://github.com/mxw/vim-jsx'

" scala
Plug 'derekwyatt/vim-scala'

" Plug 'critiqjo/lldb.nvim'
Plug 'neomake/neomake'
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'https://github.com/jvirtanen/vim-octave.git'

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
"set encoding=UTF8
set secure
set hidden
set softtabstop=2
set smarttab
set copyindent
set history=1000
set undolevels=1000
set wildignore+=*.swp,*.bak,*.pyc,*.class
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
highlight Normal ctermbg=none
highlight NonText ctermbg=none
set clipboard+=unnamed
set clipboard+=unnamedplus
set go+=a
set switchbuf=usetab
set nofoldenable
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab


" MAPPINGS

nnoremap <M-j> <c-w>j
nnoremap <M-k> <c-w>k
nnoremap <M-l> <c-w>l
nnoremap <M-h> <c-w>h
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bn<CR>
nnoremap <S-l> :lnext<CR>
nnoremap <S-h> :lprev<CR>
nnoremap <C-a> :bufdo bd<CR>
noremap <C-q> :q!<CR>
inoremap <C-@> <C-x><C-o>
inoremap <C-SPACE> <C-x><C-o>
noremap <space> @q
nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
nnoremap <silent> <C-w> :lclose<CR>:Bclose<CR>
map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>


" PLUGIN SETTINGS

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
let $FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

" rust
let g:rustc_syntax_only = 1
let g:rust_recommended_style = 0
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']
au FileType rust nnoremap <C-b> :RustFmt<CR><CR>
au FileType rust nmap gd :call racer#GoToDefinition()<CR>
au FileType rust nmap gs :split<CR>:call racer#GoToDefinition()<CR>
au FileType rust nmap gx :vsplit<CR>:call racer#GoToDefinition()<CR>
au FileType rust nmap <leader>gd :call racer#ShowDocumentation()<CR>
let errorformat  =
      \ '%-Gerror: aborting due to previous error,'.
      \ '%-Gerror: aborting due to %\\d%\\+ previous errors,'.
      \ '%-Gerror: Could not compile `%s`.,'.
      \ '%Eerror[E%n]: %m,'.
      \ '%Eerror: %m,'.
      \ '%Wwarning: %m,'.
      \ '%Inote: %m,'.
      \ '%-Z\ %#-->\ %f:%l:%c,'.
      \ '%G\ %#\= %*[^:]: %m,'.
      \ '%G\ %#|\ %#%\\^%\\+ %m,'.
      \ '%I%>help:\ %#%m,'.
      \ '%Z\ %#%m,'.
      \ '%-G%s'

      "\ 'args' : ['build','--features', 'server', '--example',  'proxy'],
      "\ 'args' : ['build','--example',  'sync_mux_echo'],
      "\ 'args' : ['build'],
      "\ 'args' : ['test'],
let g:neomake_rust_bcargo_maker = {
      \ 'exe': 'cargo',
      \ 'args' : ['build','--features', 'server', '--example',  'proxy'],
      \ 'append_file': 0,
      \ 'errorformat': errorformat
      \ }
let g:neomake_rust_enabled_makers = ["bcargo"]

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:NERDTreeWinSize=30

let g:gitgutter_enabled = 1

let g:yankring_replace_n_pkey = '<C-I-O>'

let g:deoplete#enable_at_startup = 1

set tags=./tags,tags,../tags
" let g:neomake_logfile ="/var/log/neomake.log"

"requires gentag in PATH
let g:atags_build_commands_list = [ "gentags" ]

autocmd! BufWritePost * Neomake
autocmd! BufWritePost *.cpp call atags#generate()
autocmd! BufWritePost *.c call atags#generate()
" autocmd! BufWritePost *.rs call neomake#makers#cargo#cargo()

" Scala
" au FileType scala nnoremap gd :EnDeclaration<CR>
" autocmd BufWritePost *.scala :EnTypeCheck
" au FileType scala nnoremap gd :EnDeclaration<CR>

" PLUGIN MAPPINGS
"
nnoremap <C-p> :Files<CR>
nnoremap <C-n> :Tags<CR>
nnoremap <C-e> :History<CR>
nnoremap <C-_> :Ag<CR>
noremap <C-b> :Autoformat<CR><CR>
noremap <C-q> :q!<CR>

" nnoremap <C-y> :YRShow<CR>
"nmap gd :YcmCompleter GoTo<CR>
map <Tab> :NERDTreeToggle<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='distinguished'

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-i>"
let g:UltiSnipsJumpBackwardTrigger="<c-o>"
