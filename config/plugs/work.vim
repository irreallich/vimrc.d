" VIM scripts
" Author: hjwang
" Created Time : Thu 24 Oct 2019 07:15:10 AM UTC
" File Name: config/plug/work.vim
" Description:
"""
" 根据实际情况随时修改
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_work'],
            \}
function! Pluginfo_work()
    return s:pluginfo 
endfunction

function! Init_work()
endfunction 

function! Work_init() 
    if hjenv#IsWindows()
        let g:work='C:\work'
        let g:pywork=g:work.'\python'
        let g:acswork=g:pywork.'\project\acs'
        let g:acs37work=g:acswork.'\acs53py37'
        execute 'let $pyLibrary=''C:\work\python\project\ACS\acs53py37\library\pyLibrary'''
        if hjenv#IsWin32()
            "execute 'let $python=''C:\python37-32'''
        elseif hjenv#IsWin64()
            "execute 'let $python=''C:\python37'''
        endif
    else
        "for linux and mac
    endif
endfunction

" here is the work path define for myself
function! Cw(dir)
   execute ":cd  ".a:dir 
endfunction




