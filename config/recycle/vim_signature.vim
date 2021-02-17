" VIM scripts
" Author: hjwang
" Created Time : Wed 04 Mar 2020 04:46:08 AM UTC
" File Name: config/plugs/vim_signature.vim
" Description:
"""


" 古老的vim mark插件,vim-bookmark替代
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['kshenoy/vim-signature'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_vim_signature'],
            \}
function! Pluginfo_vim_signature()
    return s:pluginfo
endfunction


function! Init_vim_signature()

endfunction
