" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时57分55秒
" File Name: config/plug_conf/vimcdoc.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['yianwillis/vimcdoc'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_vimcdoc'],
            \}
function! Pluginfo_vimcdoc()
    return s:pluginfo 
endfunction

function! Init_vimcdoc()
endfunction

