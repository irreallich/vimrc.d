" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时46分49秒
" File Name: config/plug_conf/multiple_cursors.vim
" Description:
"""


" 可同时选择多个相同文本进行编辑
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['terryma/vim-multiple-cursors'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_multiple_cursors'],
            \}
function! Pluginfo_multiple_cursors()
    return s:pluginfo 
endfunction

function! Init_multiple_cursors()
endfunction
