" VIM scripts
" Author: hjwang
" Created Time : 2019年11月11日 星期一 21时48分48秒
" File Name: config/plug/bookmarks.vim
" Description:
"""

" 标记的增强插件
let s:pluginfo = {
\ 'cmdline' : [
\ ['MattesGroeger/vim-bookmarks'],
\ ],
\ 'mode'    : 'normal',
\ 'func'    : ['Init_bookmarks'],
\ 'hotkeys' : {
\   '<leader>bm':  {
\                  'cmdstart'  :'nmap  <unique> ',
\                  'cmdend'    :'<Plug>BookmarkToggle',
\                  'desc'      :'Add or remove bookmark at current line',
\                  },
\   '<leader>ba':  {
\                  'cmdstart'  :'nmap <unique> ',
\                  'cmdend'    :'<Plug>BookmarkShowAll',
\                  'desc'      :'Show bookmarks across all buffers in new window (toggle)',
\                  },
\   '<leader>bn':  {
\                  'cmdstart'  :'nmap <unique> ',
\                  'cmdend'    :'<Plug>BookmarkNext',
\                  'desc'      :'Jump to the next bookmark downwards',
\                  },
\   '<leader>bp':  {
\                  'cmdstart'  :'nmap <unique> ',
\                  'cmdend'    :'<Plug>BookmarkPrev',
\                  'desc'      :'Jump to the next bookmark upwards',
\                  },
\   '<leader>bc':  {
\                  'cmdstart'  :'nmap <unique> ',
\                  'cmdend'    :'<Plug>BookmarkClear',
\                  'desc'      :'Removes bookmarks for current buffer',
\                  },
\   '<leader>bx':  {
\                   'cmdstart'  :'nmap <unique> ',
\                   'cmdend'    :'<Plug>BookmarkClearAll',
\                   'desc'      :'Removes bookmarks for all buffer',
\                   },
\ },
\}

function! Pluginfo_bookmarks()
    return s:pluginfo 
endfunction

":help Bookmark is the help command
function! Init_bookmarks()
    "if hjenv#IsGui()
    "    highlight BookmarkSign guibg=NONE guifg=160
    "    highlight BookmarkLine guibg=194 guifg=NONE
    "else
    "    highlight BookmarkSign ctermbg=NONE ctermfg=100
    "    highlight BookmarkLine ctermbg=100 ctermfg=NONE
    "endif
    let g:bookmark_sign = '>>'
    let g:bookmark_annotation_sign = '##'

    let g:bookmark_highlight_lines = 1
    let g:bookmark_no_default_key_mappings = 1

endfunction

