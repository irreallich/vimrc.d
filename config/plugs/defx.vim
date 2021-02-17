" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 14时38分51秒
" File Name: config/plug_conf/a.vim
" Description:
"""
if hjenv#IsNvim()
    let s:cmdline = [
        \ ['Shougo/defx.nvim'],
        \ ['kristijanhusak/defx-icons'],
        \ ]
elseif hjenv#IsVim8()
    let s:cmdline = [
        \ ['Shougo/defx.nvim'],
        \ ['roxma/nvim-yarp'],
        \ ['roxma/vim-hug-neovim-rpc'],
        \ ]
endif

let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_defx'],
            \ 'hotkeys' : {
            \               '<CR>':     {
            \                               'cmdstart'  :'nnoremap <silent><buffer><expr>',
            \                               'cmdend'    :'defx#do_action("open")',
            \                               'desc'      :'打开当前文件',
            \                           },
            \             },
            \}

function! Pluginfo_defx()
    return s:pluginfo 
endfunction
let s:pluginfo.cmdline = s:cmdline


function! Init_defx()
    call s:defx_init()            
endfunction


function! s:defx_init()
    call defx#custom#option(
        \ '_', 
        \ {
        \ 'columns': 'indent:git:icons:filename',
        \ 'winwidth': 30,
        \ 'split': 'vertical',
        \ 'direction': 'topleft',
        \ 'listed': 1,
        \ 'buffer_name': '',
        \ 'toggle': 1,
        \ 'resume': 1,
        \ 'show_ignored_files': 0,
        \ 'ignored_files':
        \     '.hg,.git'
        \   . ',__pycache__,*.pyc,*.pyd,*.swp',
        \ },
    \ )

endfunction

"autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() 
    " Define mappings
    nnoremap <silent><buffer><expr> o     defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> <CR>  defx#do_action('open')
    nnoremap <silent><buffer><expr> c     defx#do_action('copy')
    nnoremap <silent><buffer><expr> m     defx#do_action('move')
    nnoremap <silent><buffer><expr> p     defx#do_action('paste')
    nnoremap <silent><buffer><expr> l     defx#do_action('open')
    nnoremap <silent><buffer><expr> E     defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> P     defx#do_action('open', 'pedit')
    nnoremap <silent><buffer><expr> K     defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N     defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M     defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C     defx#do_action('toggle_columns',
                      \ 'mark:indent:icon:filename:type:size:time')
    nnoremap <silent><buffer><expr> S     defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d     defx#do_action('remove')
    nnoremap <silent><buffer><expr> r     defx#do_action('rename')
    nnoremap <silent><buffer><expr> !     defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x     defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy    defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;     defx#do_action('repeat')
    nnoremap <silent><buffer><expr> h     defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~     defx#do_action('cd')
    nnoremap <silent><buffer><expr> q     defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *     defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j     line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k     line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
    nnoremap <silent><buffer><expr> cd    defx#do_action('change_vim_cwd')

    nnoremap <silent><buffer><expr> f defx#do_action('call', 'Test')
endfunction

" the following is used to test
function! Test(context) 
    echomsg string(a:context.targets)
endfunction

