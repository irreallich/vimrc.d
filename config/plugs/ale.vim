" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时20分56秒
" File Name: config/plug_conf/ale.vim
" Description:
"""

"['w0rp/ale',"'on': 'ALEToggle'"],
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
\ 'cmdline' : [
\   ['dense-analysis/ale',"'on': 'ALEToggle'"],
\   ],
\ 'mode'    : 'cmd',
\ 'func'    : ['Init_ale'],
\}
function! Pluginfo_ale()
    return s:pluginfo
endfunction

function! Init_ale()

    "let g:ale_fix_on_save = 1 " 在文件保存时自动fix
    " 总是显示结果侧边
    let g:ale_sign_column_always = 1
    "let g:ale_set_quickfix = 1
    "let g:ale_open_list = 1

    " 设定检测的时机：normal 模式文字改变，或者离开 insert模式
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 1

    " 设定延迟和提示信息
    let g:ale_completion_delay = 500
    let g:ale_echo_delay = 20
    let g:ale_lint_delay = 500
    let g:ale_echo_msg_format = '[%linter%] %code: %%s'

    " 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
    " 仅使用 ale_linters 中定义的lints作为静态代码检测工具.
    if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
        let g:ale_command_wrapper = 'nice -n5'
        let g:ale_linters = {
        \ 'c': ['clang'],
        \ 'cpp': ['clang'],
        \ 'python': ['pylint'],
        \ 'bash': ['shellcheck'],
        \ 'vim': ['vint']
        \ }
    else
        let g:ale_linters_explicit = 1
        let g:ale_linters = {
        \ 'c': ['cppcheck',],
        \ 'cpp': ['cppcheck',],
        \ 'python': ['pylint'],
        \ 'bash': ['shellcheck'],
        \ 'vim': ['vint']
        \ }
    endif
    " 使用airline的时候添加airline集成
    if exists('g:loaded_airline') && g:loaded_airline == 1
        let g:airline#extensions#ale#enabled = 1
    endif


    let g:ale_python_flake8_options = '--conf='
        \ . hjinit#get('path','settings') . hjinit#get('sys','dir_sep') . 'flake8.conf'
    let g:ale_python_pylint_options = '--rcfile='. 
        \ hjinit#get('path','settings') . hjinit#get('sys','dir_sep') . 'pylint.conf'
    let g:ale_python_pylint_options .= ' --disable=W'
    let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
    let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
    let g:ale_c_cppcheck_options = ''
    let g:ale_cpp_cppcheck_options = '' 
    
    let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']

    if executable('gcc') == 0 && executable('clang')
        let g:ale_linters.c += ['clang']
        let g:ale_linters.cpp += ['clang']
    endif

    " 设置fixer
    let g:ale_fixers            = {"*": ["remove_trailing_lines", "trim_whitespace"] }
    let g:ale_fixers.c          = ['clang-format']
    let g:ale_fixers.cpp        = ['clang-format']
    let g:ale_fixers.vim        = ['vint']
    let g:ale_fixers.python     = [
        \ 'qsort',
        \ 'remove_trailing_lines',
        \ 'trim_whitespace',
        \ 'add_blank_lines_for_python_control_statements',
        \ 'reorder-python-imports',
        \ 'autopep8',
        \ 'yapf'
        \ ]
    let g:ale_fixers.vim        = ['shfmt']

endfunction
