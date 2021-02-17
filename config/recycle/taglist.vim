" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时10分17秒
" File Name: config/plug_conf/taglist.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['vim-scripts/taglist.vim'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_taglist'],
            \}
function! Pluginfo_taglist()
    return s:pluginfo 
endfunction

function! Init_taglist()
    let Tlist_Sort_Type = "name"
    let Tlist_Auto_Open = 0
    if hjenv#IsWindows()
        let Tlist_Ctags_Cmd = "ctags.exe"
    else
        let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
    endif
    " auto close taglist 
    let Tlist_File_Fold_Auto_Close = 1
    " Close Vim if the taglist is the only window 
    let Tlist_Exit_OnlyWindow = 1
    let Tlist_Use_Right_Window = 0
    let Tlist_Compart_Format = 1
    let Tlist_Show_One_File=1
endfunction


