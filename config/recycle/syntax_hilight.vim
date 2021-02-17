" VIM scripts
" Author: hjwang
" Created Time : Mon 09 Mar 2020 05:46:05 AM UTC
" File Name: /home/hjwang/work/config/vimrc.d/config/recycle/syntax_hilight.vim
" Description:
"""



" 单独定义的语法高亮文件，功能和vim_polyglot重复
"\ ['octol/vim-cpp-enhanced-highlight',"'for': ['c','cpp']"],
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['pprovost/vim-ps1',"'for': 'ps1'"],
                        \ ['tbastos/vim-lua',"'for': 'lua'"],
                        \ ['octol/vim-cpp-enhanced-highlight',"'for': ['cpp']"],
                        \ ['justinmk/vim-syntax-extra',"'for': ['c']"],
                        \ ['vim-python/python-syntax',"'for': 'python'"],
                        \ ['pboettch/vim-cmake-syntax',"'for': 'cmake'"],
                        \ ['elzr/vim-json',"'for': 'json'"],
                        \ ['amadeus/vim-xml',"'for': 'xml'"],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_syntax_hilight'],
            \}
function! Pluginfo_syntax_hilight()
    return s:pluginfo
endfunction

function! Init_syntax_hilight()
    call s:python_syntax_init()
    call s:c_syntax_init()

endfunction

function! s:python_syntax_init()
    " for vim-python/python-syntax
    let g:python_highlight_all = 1
endfunction
function! s:c_syntax_init()
    " for vim-cpp-enhanced-highlight
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    let g:cpp_posix_standard = 1
    let g:cpp_experimental_simple_template_highlight = 1
    let g:cpp_concepts_highlight = 1
endfunction
