" VIM scripts
" Author: hjwang
" Created Time : Fri 25 Oct 2019 08:24:40 AM UTC
" File Name: config/plug/python_syntax.vim
" Description:
"""

let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['vim-python/python-syntax'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_python_syntax'],
            \}
function! Pluginfo_python_syntax()
    return s:pluginfo 
endfunction

function! Init_python_syntax()
endfunction 

"recorder for syntax highhight 
" ['octol/vim-cpp-enhanced-highlight', ", \{ \'on\': [] \}"],
" ['vim-jp/vim-cpp', ", \{ \'on\': [] \}"],
" ['sheerun/vim-polyglot', ", \{ \'on\': [] \}"],
" ['justinmk/vim-syntax-extra', ", \{ \'on\': [] \}"],
" ['vim-python/python-syntax', ", \{ \'on\': [] \}"],
" ['nanotech/jellybeans.vim', ", \{ \'on\': [] \}"],
" ['chriskempson/tomorrow-theme', ", \{ \'on\': [] \}"],
" ['NLKNguyen/papercolor-theme', ", \{ \'on\': [] \}"],
" ['aonemd/kuroi.vim', ", \{ \'on\': [] \}"],
" ['benburrill/potato-colors', ", \{ \'on\': [] \}"],

