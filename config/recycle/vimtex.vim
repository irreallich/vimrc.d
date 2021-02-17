" VIM scripts
" Author: hjwang
" Created Time : 2020年09月02日 星期三 15时50分38秒
" File Name: /home/hjwang/work/config/vimrc.d/config/plugs/vimtex.vim
" Description:
"""



let s:filename = fnamemodify(expand("<sfile>"), ":t:r")

let s:pluginfo = {
\ "cmdline" : [
            \ ['lervag/vimtex'],
            \ ],
\ "mode"    : "normal",
\ "func"    : ["Init_vimtex"],
\}

function! Pluginfo_vimtex()
    return s:pluginfo
endfunction

function! Init_vimtex()
    "let g:tex_flavor='latex'
    "let g:vimtex_view_method='zathura'
    "let g:vimtex_quickfix_mode=0
    "let g:tex_conceal='abdmg
endfunction

