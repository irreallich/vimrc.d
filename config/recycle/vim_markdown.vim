" VIM scripts
" Author: hjwang
" Created Time : 2020/2/26 14:19:19
" File Name: D:\\work\\config\\vimrc.d\config\plugs\vim_markdown.vim
" Description:
"""

" vim-polyglot 里包含这个插件
let s:filename = fnamemodify(expand("<sfile>"), ":t:r")

let s:pluginfo = {
\ "cmdline" : [
    \ ['plasticboy/vim-markdown'],
    \ ['mzlogin/vim-markdown-toc'],
    \ ['iamcco/markdown-preview.vim'],
\ ],
\ "mode"    : "normal",
\ "func"    : ["Init_vim_markdown"],
\}

"[[ "跳转上一个标题
"]] "跳转下一个标题
"]c "跳转到当前标题
"]u "跳转到副标题
"zr "打开下一级折叠
"zR "打开所有折叠
"zm "折叠当前段落
"zM "折叠所有段落
":Toc "显示目录
function! Pluginfo_vim_markdown()
    return s:pluginfo
endfunction

function! Init_vim_markdown()
    call s:markdown_init()
endfunction

function! s:markdown_init()
    " for plasticboy/vim-markdown
    " 代码折叠
    let g:vim_markdown_folding_disabled = 0  
    "let g:vim_markdown_folding_level = 1
    " 默认热键
    "let g:vim_markdown_no_default_key_mappings = 0 


    let g:vim_markdown_auto_insert_bullets = 0

    " vim-markdown的concealcursor特性与indentLine冲突
    " 要关闭concealcursor功能,需要 设置这个
    "set conceallevel=0
    "set concealcursor=
    "
    "let g:vim_markdown_conceal = 0

    " for  vim-markdown-toc
    "取消储存时自动更新目录
    let g:vmt_auto_update_on_save = 0
    
    " for markdown-preview
    let g:mkdp_path_to_chrome = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
endfunction

