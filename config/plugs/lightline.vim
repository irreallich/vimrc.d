" VIM scripts
" Author: hjwang
" Created Time : 9/23/2019 6:28:45 PM
" File Name: config\plug_conf\lightline.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['itchyny/lightline.vim'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_lightline'],
            \}
function! Pluginfo_lightline()
    return s:pluginfo 
endfunction

function! Init_lightline()
    "according to the readme page of lightline, the following setting is necessary
    let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'component_function': {
        \ 'method_right': 'NearestMethodOrFunction'
        \ }, 
    \ }
endfunction    




