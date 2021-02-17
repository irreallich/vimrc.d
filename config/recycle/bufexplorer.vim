" VIM scripts
" Author: hjwang
" Created Time : 2019年08月15日 星期四 16时21分05秒
" File Name: /home/hjwang/work/config/vimrc.d/config/plug_conf/bufexplorer.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['jlanzarotta/bufexplorer'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_bufexplorer'],
            \}
function! Pluginfo_bufexplorer()
    return s:pluginfo 
endfunction

function! Init_bufexplorer()
    let g:bufExplorerDefaultHelp=0       " Do not show default help.
    let g:bufExplorerShowRelativePath=1  " Show relative paths.
    let g:bufExplorerSortBy='number'        " Sort by most recently used.
    let g:bufExplorerSplitRight=1        " Split left.
    let g:bufExplorerSplitVertical=1     " Split vertically.
    let g:bufExplorerSplitVertSize = 0   " Split width
    let g:bufExplorerUseCurrentWindow=1  " Open in new window.
endfunction
