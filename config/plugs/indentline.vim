" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时43分18秒
" File Name: config/plug_conf/indentLine.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' :   [
            \               ['Yggdroot/indentLine'],
            \               ],
            \ 'mode'    :   'normal',
            \ 'func'    :   ['Init_indentline'],
            \}
function! Pluginfo_indentline()
    return s:pluginfo 
endfunction

function! Init_indentline()
    "let g:indentLine_noConcealCursor = 1

    " set as sublime
    "let g:indentLine_char = '┊'

    " 使用indentline默认的灰色覆盖隐藏颜色
    " 可以用来防止某些themes下出现在对其标记上的背景色
    let g:indentLine_setColors = 1

    " 显示空格，效果不好看
    let g:indentLine_leadingSpaceChar = '.'
    let g:indentLine_leadingSpaceEnabled = 0

    " 设置这个的目的是禁止indentline在某些需要quotes的地方运行,从而显示quote
    let g:indentLine_fileType = ['c', 'cpp','python','vim','sh']
    let g:indentLine_fileTypeExclude = ['text']
    let g:indentLine_bufTypeExclude = ['help', 'terminal']

endfunction
