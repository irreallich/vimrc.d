" VIM scripts
" Author: hjwang
" Created Time : 2019年10月16日 星期三 06时02分54秒
" File Name: config/plug/themes.vim
" Description:
"""

" vim-colorschemes' 大而全的vim colorschemes, 更新比较缓慢
"    \ ['flazz/vim-colorschemes'],
"

"let s:cmdline = [
"    \ ['ayu-theme/ayu-vim'],
"    \ ['arcticicestudio/nord-vim'],
"    \ ]
" 添加常用的themes
let s:cmdline=[]
call add(s:cmdline,['ayu-theme/ayu-vim']) " 还不错
call add(s:cmdline,['arcticicestudio/nord-vim']) " 对比度比较低,不容易分辨关键字
call add(s:cmdline,['liuchengxu/space-vim-theme']) 
call add(s:cmdline,['rakr/vim-one']) 
call add(s:cmdline,['lifepillar/vim-solarized8']) 

let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_themes'],
            \}
function! Pluginfo_themes()
    return s:pluginfo
endfunction
let s:pluginfo.name = s:filename
let s:pluginfo.cmdline = s:cmdline


function! Init_themes()
    if !exists('g:hjvim_config.sys.themes')
        let g:hjvim_config.sys.themes = {}
        let g:hjvim_config.sys.themes.colorscheme = 'gruvbox'
        let g:hjvim_config.sys.themes.background = 'dark'
        return 
    endif

    let l:themes =  hjinit#get('sys','themes')
    " for gruvbox
    if g:hjvim_config.sys.themes.colorscheme == 'gruvbox'
        let g:gruvbox_contrast_dark='hard'
    endif

    " for ayu 
    if l:themes.colorscheme == 'ayu'
        let g:ayucolor = l:themes.background 
    endif

    try
        execute 'colorscheme ' . l:themes.colorscheme
        if l:themes.colorscheme != 'ayu'
            execute 'set background=' . l:themes.background
        endif
    catch
        " 自带gruvbox的themes,如果找不到其他的themes,默认使用自带的gruvbox
        let g:hjvim_config.sys.themes = {}
        let g:hjvim_config.sys.themes.colorscheme = 'gruvbox'
        let g:hjvim_config.sys.themes.background = 'dark'
        let g:gruvbox_contrast_dark='hard'
        execute 'set background=' . g:hjvim_config.sys.themes.background 
        execute 'colorscheme ' . g:hjvim_config.sys.themes.colorscheme 
    endtry
endfunction


