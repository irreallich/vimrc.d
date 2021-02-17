" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时55分09秒
" File Name: config/plug_conf/rainbow.vim
" Description:
"""

" rainbow need auto load, otherwise it couldn't work fine

let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['luochen1990/rainbow'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_rainbow'],
            \}
function! Pluginfo_rainbow()
    return s:pluginfo 
endfunction

function! Init_rainbow()
    let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle        
    let g:rainbow_conf = {}
    let g:rainbow_conf.guifgs =  ['#d65d0e', '#cc241d', '#b16286', '#458588']
    let g:rainbow_conf.ctermfgs =  ['166', 'green', 'magenta', 'blue']
endfunction
