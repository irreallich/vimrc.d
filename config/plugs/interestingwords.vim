" VIM scripts
" Author: hjwang
" Created Time : 2019年11月11日 星期一 21时24分35秒
" File Name: config/plug/interestingwords.vim
" Description:
"""

" 增加多个高亮选择
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['lfv89/vim-interestingwords'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_interestingwords'],
            \ 'hotkeys' : {
            \               '<leader>k':  {
            \                              'desc'      :'高亮/解除高亮字符',
            \                             },
            \               '<leader>K':  {
            \                              'desc'      :'解除所有高亮字符',
            \                             },
            \               'n':          {
            \                              'desc'      :'跳转到下一个，会覆盖默认的n健功能，清除后恢复',
            \                             },
            \               'N':          {
            \                              'desc'      :'跳转到上一个，会覆盖默认的N健功能，清除后恢复',
            \                             },
            \             },
            \}
function! Pluginfo_interestingwords()
    return s:pluginfo 
endfunction

function! Init_interestingwords()
    if hjenv#IsGui()
        let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
    else
        let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']
    endif
    "let g:interestingWordsRandomiseColors = 1
endfunction

