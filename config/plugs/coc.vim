" VIM scripts
" Author: hjwang
" Created Time : Mon 30 Dec 2019 06:13:19 AM UTC
" File Name: config/plugs/coc.vim
" Description:
"""

let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
            \             ['neoclide/coc.nvim'," 'branch': 'release' "],
            \             ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_coc'],
            \ 'hotkeys' : {
            \               '<TAB>':        {
            \                               'cmdstart'  :'inoremap <silent><expr> ',
            \                               'cmdend'    :'pumvisible() ? "\<C-n>" :  Check_back_space() ? "\<TAB>" :  coc#refresh()',
            \                               'desc'      :'使用tab作为补全快捷键',
            \                               },
            \               '<c-y>':        {
            \                               'cmdstart'  :'inoremap <silent><expr> ',
            \                               'cmdend'    :'coc#refresh()',
            \                               'desc'      :'使用<c-h>触发补全',
            \                               },
            \               '<cr>':         {
            \                               'cmdstart'  :'inoremap <expr> ',
            \                               'cmdend'    :'pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"',
            \                               'desc'      :'使用<cr>确认补全',
            \                               },
            \               '<leader>ytj':   {
            \                               'cmdstart'  :'nmap <silent>',
            \                               'cmdend'    :'<Plug>(coc-definition)',
            \                               'desc'      :'跳转到定义位置',
            \                               },
            \               '<leader>ytr':   {
            \                               'cmdstart'  :'nmap <silent>',
            \                               'cmdend'    :'<Plug>(coc-references)',
            \                               'desc'      :'跳转到引用位置',
            \                               },
            \             },
            \}

function! Pluginfo_coc()
    return s:pluginfo 
endfunction

function! Init_coc() 
    "  设置coc配置文件的位置 
    "if hjenv#IsWindows()
    "    let g:coc_extension_root = $VIMFILES . '\coc_config'
    "    let g:coc_config_home = $VIMFILES . '\coc_config'
    "else
    "    let g:coc_extension_root = $VIMFILES . '/coc_config'
    "    let g:coc_config_home = $VIMFILES . '/coc_config'
    "endif


endfunction

function! Check_back_space() 
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction



