""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 


""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return 
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => CoffeeScript section
"""""""""""""""""""""""""""""""
function! CoffeeScriptFold()
    setl foldmethod=indent
    setl foldlevelstart=1
endfunction
au FileType coffee call CoffeeScriptFold()

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

autocmd FileType cpp noremap <CR> :make!<cr>

autocmd FileType scala nnoremap <CR> :exe 'w' <bar> !sbt compile<cr>
autocmd FileType scala nnoremap <D-CR> :exe 'w' <bar> !sbt run<cr>
autocmd FileType scala nnoremap <c-CR> :exe 'w' <bar> !sbt test<cr>
autocmd FileType scala inoremap gd <c-]>

autocmd FileType rust nnoremap <CR> :exe 'w' <bar> !RUST_BACKTRACE=1 cargo build<cr>
autocmd FileType rust nnoremap <D-CR> :exe 'w' <bar> !RUST_BACKTRACE=1 cargo run<cr>
autocmd FileType rust nnoremap <c-CR> :exe 'w' <bar> !RUST_BACKTRACE=1 cargo test<cr>

au FileType javascript nmap <CR> :!node % <CR>
autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') != '' ? ['eslint'] : ['standard']

au FileType python set omnifunc=pythoncomplete#Complete
au FileType python nmap <CR> :!python2.7 % <CR>

"custom fletype color themes
" autocmd FileType rust set background=dark
" autocmd FileType rust colo solarized
