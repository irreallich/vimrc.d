" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时24分28秒
" File Name: config/plug_conf/asyncrun.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
\ 'cmdline' : [
\   ['skywind3000/asyncrun.vim'],
\   ],
\ 'mode'    : 'normal',
\ 'func'    : ['Init_asyncrun'],
\ 'hotkeys' : {
\   '<leader><leader>g':  {
\       'cmdstart'  :'noremap <silent>',
\       'cmdend'    :':AsyncRun python %<CR>',
\       'desc'      :'asyncrun 当前文件python代码',
\       },
\   },
\}
function! Pluginfo_asyncrun()
    return s:pluginfo 
endfunction

function! Init_asyncrun()
    let g:asyncrun_status = ''
    let g:asyncrun_open = 8
    "let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])    
    
endfunction
