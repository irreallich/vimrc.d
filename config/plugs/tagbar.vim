" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时08分03秒
" File Name: config/plug_conf/tagbar.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['majutsushi/tagbar',"'on': 'Tagbar'"],
                        \ ],
            \ 'mode'    : 'cmd',
            \ 'func'    : ['Init_tagbar'],
            \}
function! Pluginfo_tagbar()
    return s:pluginfo 
endfunction

function! Init_tagbar()
    "let g:tagbar_width=30
    let g:tagbar_autofocus=1
    let g:tagbar_sort=0  "sorted by location
    let g:tagbar_previewwin_pos = "rightbelow"
    let g:tagbar_autopreview = 0

    
    "let g:tagbar_iconchars = ['▶', '▼']  "(default on Linux and Mac OS X)
    let g:tagbar_iconchars = ['+', '-']  "(default on Windows)

    "autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
endfunction

