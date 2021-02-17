" VIM scripts
" Author: hjwang
" Created Time : 2/13/2020 5:10:14 PM
" File Name: C:\Users\hwang29\work\config\vimrc.d\config\plugs\vim_dirvish.vim
" Description:
"""


" 一个vimscript的函数库
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['xolox/vim-misc'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_vim_misc'],
            \}
function! Pluginfo_vim_misc()
    return s:pluginfo
endfunction


function! Init_vim_misc()

endfunction
