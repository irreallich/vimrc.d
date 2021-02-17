" VIM scripts
" Author: hjwang
" Created Time : 2/13/2020 10:44:40 PM
" File Name: C:\Users\hwang29\work\config\vimrc.d\config\plugs\vim_fugitive.vim
" Description:
"""


" vim git 插件
let s:filename = fnamemodify(expand("<sfile>"), ":t:r")

let s:pluginfo = {
            \ "cmdline" : [
                        \ ['tpope/vim-fugitive'],
                        \ ],
            \ "mode"    : "normal",
            \ "func"    : ["Init_vim_fugitive"],
            \}

function! Pluginfo_vim_fugitive()
    return s:pluginfo
endfunction

function! Init_vim_fugitive()
endfunction

