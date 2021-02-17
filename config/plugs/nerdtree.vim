" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时53分06秒
" File Name: config/plug_conf/nerdtree.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['scrooloose/nerdtree',"'on': 'NERDTreeToggle'"],
                        \ ['tiagofumo/vim-nerdtree-syntax-highlight'],
                        \ ['Xuyuanp/nerdtree-git-plugin'],
                        \ ],
            \ 'mode'    : 'cmd',
            \ 'func'    : ['Init_nerdtree'],
            \}
function! Pluginfo_nerdtree()
    return s:pluginfo 
endfunction

function! Init_nerdtree()
    call s:nerdtree_init()
    call s:nerdtree_git_init()
endfunction


function! s:nerdtree_init()
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeHijackNetrw = 0                   " 禁止使用nerdtree打开通过命令 e+目录地址 打开的目录  

    " 设置窗口位置
    let g:NERDTreeWinPos='left'                     " NERDTree windows position
    " 设置不显示的文件
    let g:NERDTreeIgnore=['\.o$[[file]]','\.pyc$[[file]]','\.PYC$[[file]]','\.so$[[file]]','\.pyd$[[file]]']


endfunction

function! s:nerdtree_git_init()
    if hjenv#IsWindows()
        " 需要使用nord字体, 例如在generic.vim中选择更纱黑体_Mono_SC_Nerd:h14:W300:cANSI:qDRAFT
        let g:NERDTreeGitStatusUseNerdFonts = 0
    else
        let g:NERDTreeGitStatusIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ 'Ignored'   : '☒',
            \ "Unknown"   : "?"
            \}
    endif
endfunction

