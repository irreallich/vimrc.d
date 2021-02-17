" VIM scripts
" Author: hjwang
" Created Time : 2020年06月08日 星期一 10时49分26秒
" File Name: /home/hjwang/work/config/vimrc.d/ginit.vim
" Description:
" neovim图形界面的设置
"""

if exists('g:GuiLoaded')
    " 设置图形界面的字体
    exe 'Guifont! Monaco_for_Powerline:h12:w7:cANSI:qDRAFT'
    "exe 'Guifont! SauceCodePro Nerd Font Mono:h11:cANSI:qDRAFT'
    
    " 使用nvim自带的tabline
    " autocmd UIEnter * execute 'GuiTabline 0'
    " 使用 nvim自带的pupopmenu
    " autocmd UIEnter * execute 'GuiPopupmenu 0'
    
    " 使用 nvim自带的pupopmenu
    if exists(':GuiPopupmenu') == 2
        GuiPopupmenu 0
    endif
  
    " 使用nvim自带的tabline
    if exists(':GuiTabline') == 2
        GuiTabline 0
    endif
endif


