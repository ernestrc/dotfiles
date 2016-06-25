"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important: 
"       This requries that you install https://github.com/amix/vimrc !
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
call pathogen#infect('~/.dotfiles/vim/sources_forked/{}')
call pathogen#infect('~/.dotfiles/vim/sources_non_forked/{}')
call pathogen#helptags()

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_next_key="\<C-s>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
"let g:airline_theme="kolor"
let g:airline_theme="badwolf"
"let g:airline_left_sep = '⎬'
"let g:airline_right_sep = '⎬'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '♌'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = '❭'
"let g:airline#extensions#tabline#left_alt_sep = '❱'
let g:airline_powerline_fonts= 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_python_checkers=['pyflakes']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']


let g:NERDTreeWinSize=30
let g:gitgutter_enabled = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1


let g:rust_recommended_style = 1
let g:ycm_rust_src_path = '/usr/local/src/rust/src'
let g:ycm_global_ycm_extra_conf = "~/.dotfiles/vim/.ycm_extra_conf.py"

" to avoid clash with ultisnips
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:yankring_replace_n_pkey = '<C-I-O>'

" CtrlP auto cache clearing.
" ----------------------------------------------------------------------------
function! SetupCtrlP()
  if exists("g:loaded_ctrlp") && g:loaded_ctrlp
    augroup CtrlPExtension
      autocmd!
      autocmd FocusGained  * CtrlPClearCache
      autocmd BufWritePost * CtrlPClearCache
    augroup END
  endif
endfunction
if has("autocmd")
  autocmd VimEnter * :call SetupCtrlP()
endif

let g:ctrlp_custom_ignore ='target\|node_modules\|^\.DS_Store\|^\.git\|^\.coffee|^.class'

set tags=./tags,tags,../tags
