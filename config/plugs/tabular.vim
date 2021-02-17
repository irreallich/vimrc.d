" VIM scripts
" Author: hjwang
" Created Time : 2/14/2020 12:05:26 PM
" File Name: C:\Users\hwang29\work\config\vimrc.d\config\plugs\tabular.vim
" Description:
"""

" 基于正则表达式来表格化内容
let s:filename = fnamemodify(expand("<sfile>"), ":t:r")

let s:pluginfo = {
            \ "cmdline" : [
                        \ ['godlygeek/tabular'],
                        \ ],
            \ "mode"    : "normal",
            \ "func"    : ["Init_tabular"],
            \}

function! Pluginfo_tabular()
    return s:pluginfo
endfunction

function! Init_tabular()
endfunction

