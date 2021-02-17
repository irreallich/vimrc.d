" VIM scripts
" Author: hjwang
" Created Time : 2019年10月16日 星期三 05时57分59秒
" File Name: config/plug/vim_polyglot.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['sheerun/vim-polyglot'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_vim_polyglot'],
            \}
function! Pluginfo_vim_polyglot()
    return s:pluginfo 
endfunction

function! Init_vim_polyglot()
    call s:python_syntax_init()
    call s:c_syntax_init()
endfunction 


" 此插件中包含vim-markdown, 其与indentline的conceallevel冲突,会导致Json,md等格式的""等quotes显示不出来


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
    let g:cpp_concepts_highlight = 1

    "Note: C++ template syntax is notoriously difficult to parse, so don't expect this feature to be perfect.
    "let g:cpp_experimental_template_highlight = 1
    "let g:cpp_experimental_simple_template_highlight = 1
endfunction
