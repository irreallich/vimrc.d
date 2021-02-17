" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 14时38分51秒
" File Name: config/plug_conf/a.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
\ 'cmdline' : [
\   ['tracyone/a.vim'],
\   ],
\ 'mode'    : 'normal',
\ 'func'    : ['Init_a'],
\ 'hotkeys' : {
\   ':A':  {
\       'desc':':A switches to the header file corresponding to the current file being  edited (or vise versa)',
\   },
\   ':AS': {
\       'desc':'splits and switches',
\   },
\   ':AV': {
\       'desc':'vertical splits and switches',
\   },
\   ':AT': {
\       'desc':'new tab and switches',
\   },
\   ':IH': {
\       'desc':'switches to file under cursor',
\   },
\   ':IHS': {
\       'desc':'splits and switches',
\   },
\   ':IHV': {
\       'desc':'vertical splits and switches',
\   },
\   ':IHT': {
\       'desc':'new tab and switches',
\   },
\   ':IHN': {
\       'desc':'cycles through matches',
\   },
\   },
\}
function! Pluginfo_a()
    return s:pluginfo 
endfunction

function! Init_a()
endfunction



