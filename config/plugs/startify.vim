" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时56分06秒
" File Name: config/plug_conf/startify.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['mhinz/vim-startify'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_startify'],
            \ 'hotkeys' : {
            \               '<leader>ss':  {
            \                               'cmdstart'  :'noremap <silent>',
            \                               'cmdend'    :':Startify<cr>',
            \                               'desc'      :'打开startify',
            \                               },
            \              },
            \}

function! Pluginfo_startify()
    return s:pluginfo 
endfunction

"        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },

function! Init_startify()
    let g:startify_session_dir = hjinit#get('path','plugdir') . hjinit#get('sys','dir_sep') .'session'
    let g:startify_lists = [
        \ { 'type': 'sessions',  'header': ['   Sessions']          },
        \ { 'type': 'files',     'header': ['   MRU-files']         },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
    let g:startify_change_to_dir = 1
    let g:startify_files_number = 5 
    let g:startify_change_to_vcs_root = 0
    let g:startify_session_sort = 1
    let g:startify_custom_header = []
    
    "let g:startify_commands = [
    "\]
    

endfunction

function! s:save_cmd_ref()
    nnoremap <Leader>sh :Startify<cr>
    call hjutils#help_comments('startify','<leader>sh','打开startify')
    nnoremap <Leader>ss :SSave<cr>
    call hjutils#help_comments('startify','<leader>ss','保存当前session')
    nnoremap <Leader>sl :SLoad 
    call hjutils#help_comments('startify','<leader>sl','Load session')
    nnoremap <Leader>sd :SDelete<cr>
    call hjutils#help_comments('startify','<leader>sd','删除session')
endfunction


