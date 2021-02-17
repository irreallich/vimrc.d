" VIM scripts
" Author: hjwang
" Created Time : 2020年05月19日 星期二 11时23分13秒
" File Name: /home/hjwang/work/config/vimrc.d/config/plugs/vim_devicons.vim
" Description:
"""



let s:filename = fnamemodify(expand("<sfile>"), ":t:r")

let s:pluginfo = {
    \ "cmdline" : [
    \   ['ryanoasis/vim-devicons'],
    \ ],
    \ "mode"    : "normal",
    \ "func"    : ["Init_vim_devicons"],
    \}

function! Pluginfo_vim_devicons()
    return s:pluginfo
endfunction

function! Init_vim_devicons()
endfunction

