" VIM scripts
" Author: hjwang
" Created Time : 2/13/2020 10:38:59 PM
" File Name: C:\Users\hwang29\work\config\vimrc.d\config\plugs\errormarker.vim
" Description:
"""



let s:filename = fnamemodify(expand("<sfile>"), ":t:r")

let s:pluginfo = {
            \ "cmdline" : [
                        \ ['mh21/errormarker.vim'],
                        \ ],
            \ "mode"    : "normal",
            \ "func"    : ["Init_errormarker"],
            \}

function! Pluginfo_errormarker()
    return s:pluginfo
endfunction

function! Init_errormarker()
    " distinguish between warnings and errors for gcc messages, place sth.
    let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat
    "use a different locale than English
    "set makeprg=LANGUAGE=C\ make

endfunction

