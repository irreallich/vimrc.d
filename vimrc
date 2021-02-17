" hjwang vimrc file
" it is used for c/c++ and python
" The vim version should be more than 800


" 关闭兼容模式,如果使用-u来加载vimrc，这行必须存在
set nocompatible

" 设置leader键
let mapleader = ' '
let g:mapleader = ' '

set encoding=utf-8  " must set this value to support chinese work in vimrc

let $MYVIMRC=fnamemodify(expand('<sfile>'), ':p')
let $VIMFILES=fnamemodify(expand('<sfile>'), ':p:h')
set runtimepath+=$VIMFILES

if hjenv#IsLinux()
    "remove default folder from rtp
    if $VIMFILES !=# $HOME.'/.vim'
        set runtimepath-=$HOME/.vim
        set runtimepath-=$HOME/.vim/after
    endif
endif

function! CustomerSetting() 
    let l:plug_load_order = ['pre','auto','normal','cmd','last']
    for l:var in l:plug_load_order
        call hjinit#set('sys','plug_load_order',l:var)
    endfor

    " 一些插件如果使用的话需要将其在vim启动之前初始化,不明原因
    let l:pre_plug_list = ['vim-airline','LeaderF','rainbow']

    for l:var in l:pre_plug_list
        call hjinit#set('sys','pre_plug_list',l:var)
    endfor


    let l:ignore_plug_list = ['vista']
    "let l:ignore_plug_list = ['vista']
    if hjenv#IsNvim() 
        let l:ignore_plug_list += ['vimcdoc']
    endif
    for l:var in l:ignore_plug_list 
        call hjinit#set('sys','ignore_plug_list',l:var)
    endfor

    "call hjinit#set('sys','status_line_themes','papercolor')

    " 从tmux中获取tmux使用的themes,并与之同步
    if $TMUX != '' && $HJ_TMUX_THEMES == 'gruvbox' 
        call hjinit#set('sys','status_line_themes','gruvbox')
    endif

    "call hjinit#set('sys','themes','solarized8','dark')
    "call hjinit#set('sys','themes','ayu','mirage')
    "call hjinit#set('sys','themes','ayu','dark')
    "call hjinit#set('sys','themes','nord','dark')

    "call hjinit#set('sys','file_browser','defx')
    "call hjinit#set('sys','file_browser','vim_dirvish')

    "call hjinit#set('sys','status_line','lightline')
    "call hjinit#set('sys','tag_bar','vista')

    "call hjinit#set('sys','syntax_hilight','syntax_hilight')
    "call hjinit#set('sys','syntax_hilight','vim_polyglot')

    if hjenv#IsWindows()
        call hjinit#set('sys','shell','cmd.exe')
        call hjinit#set('sys','complete','youcompleteme')
    endif

endfunction


call hjinit#init(function('CustomerSetting'))

