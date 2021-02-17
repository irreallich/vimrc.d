" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 16时11分51秒
" File Name: config/plug_conf/autocmd.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_autocmd'],
            \}
function! Pluginfo_autocmd()
    return s:pluginfo 
endfunction

function! Init_autocmd()

    if hjenv#IsWindows()
        call s:init_win_autocmd()
    endif

    augroup filetype_group
        autocmd!
        autocmd BufRead,BufNewFile *.session setlocal filetype=vim
        autocmd BufRead,BufNewFile *.grp,*.fte setlocal filetype=vim
        autocmd BufRead,BufNewFile *.mk setlocal filetype=make
        autocmd BufRead,BufNewFile *.make setlocal filetype=make
        autocmd BufRead,BufNewFile *.cmake setlocal filetype=cmake
        autocmd BufRead,BufNewFile *.hex,*.out,*.o,*.a,*.bin Vinarise
    augroup END

    augroup load_languag_egroup
        autocmd!

        if exists('g:hjvim_config.var.groups.c')
            autocmd FileType c,cpp,objc set fileformat=unix
            autocmd FileType c,cpp,objc set shiftwidth=4 "不明原因,有些c文件此值会被设置为2,强制设置shiftwidth=4
            autocmd FileType c,cpp,objc call hjgroup#run_group(g:hjvim_config.var.groups.c)
        endif
        if exists('g:hjvim_config.var.groups.python')
            autocmd FileType python call hjgroup#run_group(g:hjvim_config.var.groups.python)
        endif

        if exists('g:hjvim_config.var.groups.bash')
            autocmd FileType sh call hjgroup#run_group(g:hjvim_config.var.groups.bash)
        endif
        if exists('g:hjvim_config.var.groups.vimscript')
            autocmd FileType vim call hjgroup#run_group(g:hjvim_config.var.groups.vimscript)
        endif
        if exists('g:hjvim_config.var.groups.markdown')
            autocmd FileType markdown call hjgroup#run_group(g:hjvim_config.var.groups.markdown)
        endif
        autocmd FileType json syntax match Comment +\/\/.\+$+
    augroup END
    
endfunction


function! s:init_win_autocmd()
    autocmd GUIEnter * simalt ~x        " windows 启动vim后自动全屏
endfunction

