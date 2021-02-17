" VIM scripts
" Author: hjwang
" Created Time : 2/13/2020 10:11:42 PM
" File Name: C:\Users\hwang29\work\config\vimrc.d\config\plugs\vim_signify.vim
" Description:
"""

" 侧边符号栏显示 git/svn 的 diff
let s:filename = fnamemodify(expand("<sfile>"), ":t:r")

let s:pluginfo = {
            \ "cmdline" : [
                        \ ['mhinz/vim-signify'],
                        \ ],
            \ "mode"    : "normal",
            \ "func"    : ["Init_vim_signify"],
            \}

function! Pluginfo_vim_signify()
    return s:pluginfo
endfunction

function! Init_vim_signify()
    let g:signify_vcs_list = ['git', 'svn']
    let g:signify_sign_add               = '+'
    let g:signify_sign_delete            = '-'
    let g:signify_sign_delete_first_line = '‾'
    let g:signify_sign_change            = '~'
    let g:signify_sign_changedelete      = g:signify_sign_change

    " git 仓库使用 histogram 算法进行 diff
    let g:signify_vcs_cmds = {
        \ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
        \}

    let g:signify_disable_by_default = 1
endfunction

