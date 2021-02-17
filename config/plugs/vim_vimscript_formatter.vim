" VIM scripts
" Author: hjwang
" Created Time : 2020年05月17日 星期日 19时56分53秒
" File Name: /home/hjwang/work/config/vimrc.d/config/plugs/vim_vimscript_formatter.vim
" Description:
"""



let s:filename = fnamemodify(expand("<sfile>"), ":t:r")

let s:pluginfo = {
            \ "cmdline" : [
            \   ['rbtnn/vim-vimscript_formatter'],
                        \ ],
            \ "mode"    : "normal",
            \ "func"    : ["Init_vim_vimscript_formatter"],
            \}

function! Pluginfo_vim_vimscript_formatter()
    return s:pluginfo
endfunction

function! Init_vim_vimscript_formatter()
endfunction

