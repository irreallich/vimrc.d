" VIM scripts
" Author: hjwang
" Created Time : Sat 07 Mar 2020 06:51:01 PM CST
" File Name: /home/hjwang/work/config/vimrc.d/config/plugs/vim_terminal_help.vim
" Description:
    "此插件会修改vim terminal的默认习惯,并修改窗口切换键
"""



let s:filename = fnamemodify(expand("<sfile>"), ":t:r")
let s:pluginfo = {
\ "cmdline" : [
\ ['skywind3000/vim-terminal-help'],
\ ],
\ "mode"    : "normal",
\ "func"    : ["Init_vim_terminal_help"],
\}

function! Pluginfo_vim_terminal_help()
    return s:pluginfo
endfunction

function! Init_vim_terminal_help()

endfunction

