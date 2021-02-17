" VIM scripts
" Author: hjwang
" Created Time : 2019年11月11日 星期一 21时38分05秒
" File Name: ./config/plug/cursorword.vim
" Description:
"""

let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['itchyny/vim-cursorword'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_cursorword'],
            \}
function! Pluginfo_cursorword()
    return s:pluginfo 
endfunction

function! Init_cursorword()
endfunction

