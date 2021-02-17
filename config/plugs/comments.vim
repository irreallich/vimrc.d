" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时24分47秒
" File Name: config/plug_conf/comments.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_comments'],
            \}
function! Pluginfo_comments()
    return s:pluginfo 
endfunction

function! Init_comments()
endfunction
