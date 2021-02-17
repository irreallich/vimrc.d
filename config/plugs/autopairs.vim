" VIM scripts
" Author: hjwang
" Created Time : 2019年08月15日 星期四 16时18分26秒
" File Name: config/plug_conf/autopairs.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['jiangmiao/auto-pairs'],
                        \ ],
            \ 'mode'    : 'ignore',
            \ 'func'    : ['Init_autopairs'],
            \}
function! Pluginfo_autopairs()
    return s:pluginfo 
endfunction

function! Init_autopairs()
    let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"','<':'>'}
endfunction 

function! Ref_autoparis()
    "设置要自动配对的符号
    let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}
    "添加要自动配对的符号<>
    "let g:AutoPairs['<']='>'
    "设置要自动配对的符号，默认为g:AutoPairs，可以通过自动命令来对不同文件类型设置不同自动匹配对符号。
    let b:AutoPairs = g:AutoPairs
    "把BACKSPACE键映射为删除括号对和引号，默认为1。
    let g:AutoPairsMapBS = 1
    "把ctrl+h键映射为删除括号对和引号，默认为1。
    let g:AutoPairsMapCh = 1
    "把ENTER键映射为换行并缩进，默认为1。
    let g:AutoPairsMapCR = 1
    "当g:AutoPairsMapCR为1时，且文本位于窗口底部时，自动移到窗口中间。
    let g:AutoPairsCenterLine = 1
    "把SPACE键映射为在括号两侧添加空格，默认为1。
    let g:AutoPairsMapSpace = 1
    "启用飞行模式，默认为0。
    let g:AutoPairsFlyMode = 0
    "启用跳出多行括号对，默认为1，为0则只能跳出同一行的括号。
    let g:AutoPairsMultilineClose = 1
endfunction

