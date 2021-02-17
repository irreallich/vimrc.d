" VIM scripts
" Author: hjwang
" Created Time : 2019年10月16日 星期三 21时20分14秒
" File Name: config/plug/vinarise.vim
" Description:
"""


" 用于编辑16进制文件
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['Shougo/vinarise.vim',"'on': 'Vinarise'"],
                        \ ],
            \ 'mode'    : 'cmd',
            \ 'func'    : ['Init_vinarise'],
            \}
function! Pluginfo_vinarise()
    return s:pluginfo 
endfunction

function! Init_vinarise()
endfunction

