" VIM scripts
" Author: hjwang
" Created Time : 2/14/2020 11:02:48 AM
" File Name: C:\Users\hwang29\work\config\vimrc.d\config\plugs\vim_diff_enhanced.vim
" Description:
"""

" vim diff 增强工具，可以支持其他算法
" help :h EnhancedDiff
" :EnhancedDiffDisable - Disable plugin (and use default Vim diff capabilities)
"
let s:filename = fnamemodify(expand("<sfile>"), ":t:r")

let s:pluginfo = {
            \ "cmdline" : [
                        \ ['chrisbra/vim-diff-enhanced'],
                        \ ],
            \ "mode"    : "normal",
            \ "func"    : ["Init_vim_diff_enhanced"],
            \}

function! Pluginfo_vim_diff_enhanced()
    return s:pluginfo
endfunction

function! Init_vim_diff_enhanced()
    if has("patch-8.1.0360")
        set diffopt+=internal,algorithm:patience
    else 
        if &diff
            let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
        endif
    endif
endfunction

