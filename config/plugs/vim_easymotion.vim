" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时56分55秒
" File Name: config/plug_conf/vim_easymotion.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['Lokaltog/vim-easymotion'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_vim_easymotion'],
            \ 'hotkeys' : {
            \               '<leader><leader>h':  {
            \                               'cmdstart'  :'map',
            \                               'cmdend'    :'<Plug>(easymotion-linebackward)',
            \                               'desc'      :'向右跳转',
            \                               },
            \               '<leader><leader>j':  {
            \                               'cmdstart'  :'map',
            \                               'cmdend'    :'<Plug>(easymotion-j)',
            \                               'desc'      :'向下跳转',
            \                               },
            \               '<leader><leader>k':  {
            \                               'cmdstart'  :'map',
            \                               'cmdend'    :'<Plug>(easymotion-k)',
            \                               'desc'      :'',
            \                               },
            \               '<leader><leader>l':  {
            \                               'cmdstart'  :'map',
            \                               'cmdend'    :'<Plug>(easymotion-lineforward)',
            \                               'desc'      :'',
            \                               },
            \               '<leader><leader>.':  {
            \                               'cmdstart'  :'map',
            \                               'cmdend'    :'<Plug>(easymotion-repeat)',
            \                               'desc'      :'',
            \                               },
            \              },
            \}
function! Pluginfo_vim_easymotion()
    return s:pluginfo 
endfunction

function! Init_vim_easymotion()
    let g:EasyMotion_smartcase = 1
    "let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
endfunction
