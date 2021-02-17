" VIM scripts
" Author: hjwang
" Created Time : 12/11/2019 1:30:41 PM
" File Name: vimrc.d/autoload/hjutils.vim
" Description:
"""

" vim utils
let s:sep_help_string = g:hjvim_config.sys.sep_help_string
let s:sep_help_len = g:hjvim_config.sys.sep_help_len
let s:log_level = 1

function! hjutils#get_files_bypath(path,extname) 
    let l:namelist = split(globpath(a:path,'*.' . a:extname))
    return l:namelist
endfunction

function! hjutils#full_screen() 
    " reset menu
    source $VIMRUNTIME/delmenu.vim
    set langmenu=none
    source $VIMRUNTIME/menu.vim
endfunction

function! hjutils#set_cmd(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

function! hjutils#space_str(num)  
    let l:space_str = ''
    let l:len = 0
    while l:len < a:num
        let l:space_str = l:space_str . ' '
        let l:len += 1
    endwhile
    return l:space_str
endfunction

function! hjutils#equal_length_str(...) 
    if a:0 == 2
        let l:len = a:1 - strlen(a:2)
        if  l:len <= 0
            call hjutils#logs(g:log_level_error,expand('<sfile>'). ':'.expand('<slnum>') . 
                \ ':'. "hjutils#equal_length_str Argument incorrect")
            return 'error' . a:2
        else
            return a:2
        endif
    elseif a:0 == 3
        let l:len = a:1 - strlen(a:2) - strlen(a:3)
        if  l:len <= 0
            call hjutils#logs(g:log_level_error,expand('<sfile>'). ':'.expand('<slnum>') . ':'. "hjutils#equal_length_str Argument incorrect")
            return 'error' . a:2 . a:3
        else
            return a:2 . hjutils#space_str(l:len) . a:3
        endif
    else
        hjutils#logs(g:log_level_error,expand('<sfile>') . ':'. "hjutils#equal_length_str Argument incorrect" )
        return 'error'
    endif
endfunction

function! hjutils#help_comments(...) 
    let l:help_keymap = hjinit#get('var','help_keymap')
    if a:0 == 2
        if !has_key(l:help_keymap , a:1)
            let l:help_keymap[a:1] = []
        endif
        call add(l:help_keymap[a:1],hjutils#equal_length_str(s:sep_help_len,a:2))
    elseif a:0 == 3
        if !has_key(l:help_keymap , a:1)
            let l:help_keymap[a:1] = []
        endif
        call add(l:help_keymap[a:1],hjutils#equal_length_str(s:sep_help_len,a:2,s:sep_help_string) . a:3)
        call uniq(sort(l:help_keymap[a:1]))
    else
        call hjutils#logs(g:log_level_error,expand('<sfile>'). ':'.expand('<slnum>') . ':'. "hjutils#help_comments Argument incorrect" )
    endif
endfunction

function! hjutils#openfile(opencmd,filename) 
    if filereadable(a:filename)
        execute a:opencmd. ' ' . a:filename
    endif
endfunction

function! hjutils#help(value) 
    let l:help_keymap = hjinit#get('var','help_keymap')
    let l:arglist = uniq(split(a:value))
    let l:argnum = len(l:arglist)
    if l:argnum == 0
        for l:str_key in keys(l:help_keymap)
            for l:str_value in l:help_keymap[l:str_key]
                echo hjutils#equal_length_str(s:sep_help_len,l:str_key,s:sep_help_string) . l:str_value
            endfor
        endfor
    elseif l:argnum >= 1
        for l:num in range(l:argnum) 
            if has_key(l:help_keymap,l:arglist[l:num])
                for l:str_value in l:help_keymap[l:arglist[l:num]]
                    echo hjutils#equal_length_str(s:sep_help_len,l:arglist[l:num],s:sep_help_string) . l:str_value
                endfor
            else
                echo "Invalid plug name, following is the list of help list:  "
                for l:str_value in keys(l:help_keymap)
                    echon l:str_value . ' '
                endfor
                echo " "
            endif
        endfor
    else
        call hjutils#logs(g:log_level_error,expand('<sfile>') . ':'.expand('<slnum>'). ':'. "Hjhelp Argument incorrect" )
    endif
endfunction

function! hjutils#logs(level, ...) 
    if a:0 > 0   
        let l:sys_level = hjinit#get('sys','log_level')
        if l:sys_level == g:log_level_warning
            let l:word = 'warning'
        elseif l:sys_level == g:log_level_error
            let l:word = 'error'
        elseif l:sys_level == g:log_level_flow
            let l:word = 'flow'
        else
            let l:word = 'none'
        endif

        if a:level <= l:sys_level
            let l:logstring = 'hj_vim_script ' . l:word . ' Log'
            for l:param in a:000
                let l:logstring = l:logstring .  ' => ' . l:param
            endfor
            echom l:logstring
        endif
    endif
endfunction

function! hjutils#edit_file(key,value) 
    let l:temp_dict = {}
    let l:extname = hjinit#get('extname',a:key)
    if a:key == 'plugs' 
        let l:values = hjinit#get('var',a:key)
        for l:value in keys(l:values)
            execute 'let l:temp_dict.' . l:value . "= \'" . l:value . '.' . l:extname . "\'"
        endfor
        if has_key(l:temp_dict,a:value)
            execute 'tabe ' . hjinit#get('path',a:key . '_cfg') . g:hjvim_config.sys.dir_sep . l:temp_dict[a:value]
        else
            echo "Please input config name , following is the list of configs :"
            for l:key in keys(l:temp_dict)
                echon l:key . ' '
            endfor
        endif
    elseif a:key == 'group' || a:key == 'feature'
        let l:values = hjutils#get_files_bypath(hjinit#get('path',a:key . '_cfg'),l:extname)
        for l:value in l:values
            execute 'tabe ' .l:value  
        endfor
    else
        call hjutils#logs(g:log_level_error,expand('<sfile>'). ':'.expand('<slnum>') . ':'. "hjutils#edit_file Argument incorrect " . a:key)
    endif
endfunction

function! hjutils#edit(key, value) 
    let l:module_name_list = hjinit#get('sys','module_name_list')

    if index(l:module_name_list,a:key) != -1
        let l:arglist = split(a:value)
        let l:argnum = len(l:arglist)
        if a:key == 'all'
            if l:argnum == 1
                call hjutils#edit_file('groups',l:arglist[-1]) 
            elseif l:argnum == 2 
                call hjutils#edit_file('features',l:arglist[-1]) 
            elseif l:argnum >= 3 
                call hjutils#edit_file('plugs',l:arglist[-1]) 
            endif
        else
            call hjutils#edit_file(a:key,l:arglist[0])
        endif
    endif    
endfunction

function! hjutils#add_fileheader()
    if (&filetype == 'c' || &filetype == 'cpp' || &filetype == 'h')
        call setline(1, "/*******************************************************************************")
        call setline(2, "\@ Author: hjwang")
        call setline(3, "\@ Created Time : ".strftime("%c"))
        call setline(4, "\@ File Name: ")
        call setline(5, "\@ ".expand("%:.")) " 确保获得当前文件的相对路径
        call setline(6, "\@ Description:")
        call setline(7, "*******************************************************************************/")
        call setline(8,"")
    endif
    if &filetype == 'shell'
        call setline(1, "\#!/bin/sh")
        call setline(2, "\# Author: hjwang")
        call setline(3, "\# Created Time : ".strftime("%c"))
        call setline(4, "\# File Name: ".expand("%:."))
        call setline(5, "\# Description:")
        call setline(6,"")
    endif
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call setline(2, "\# -*- coding=utf8 -*-")
        call setline(3, "\"\"\"")
        call setline(4, "\# Author: hjwang")
        call setline(5, "\# Created Time : ".strftime("%c"))
        call setline(6, "\# File Name: ".expand("%:."))
        call setline(7, "\# Description:") 
        call setline(8, "\"\"\"") 
        call setline(9,"") 
    endif 
    if &filetype == 'vim'
        call setline(1, "\" VIM scripts")
        call setline(2, "\" Author: hjwang")
        call setline(3, "\" Created Time : ".strftime("%c"))
        call setline(4, "\" File Name: ".expand("%:."))
        call setline(5, "\" Description:")
        call setline(6, "\"\"\"")
        call setline(7,"")
    endif
endfunc

function! hjutils#add_breakpoint(pdb)
    if a:pdb != 'ipdb' && a:pdb != 'pdb'
        let l:debug = 'pdb'
    else
        let l:debug = a:pdb
    endif
    if &filetype == 'python'
        execute 'normal ofrom '. l:debug . ' import set_trace;set_trace() #hjwang_breakpoint'
    endif
endfunction

function! hjutils#set_hotkey(key,cmdstart,cmdend,plug,desc) 
    if strlen(a:cmdstart) > 0 && strlen(a:cmdend) > 0
        call execute(a:cmdstart.' '.a:key.' '.a:cmdend)
    endif
    call hjutils#help_comments(a:plug,a:key,a:desc)
endfunction


function! hjutils#format_data(data) 
" output the formating data_struct
pyx << EOF
import pprint
output = pprint.pformat(vim.eval('a:data'),indent=1, width=100, compact=True)
vim.command('''
    function! s:format_data(input)
        let b:output = a:input
    endfunction
''')
f = vim.bindeval('function("s:format_data")')
f(output)
EOF
return b:output
endfunction


function! hjutils#add_newplug(name)
    let l:fname = hjinit#get('path','plug_conf_dir') . hjinit#get('sys','dir_sep'). a:name . '.vim'
    if filereadable(l:fname)
        call hjutils#logs(g:log_level_error,expand('<sfile>'). ':'.expand('<slnum>') . 
            \ ':'. "hjutils#add_newplug " . a:name . '.vim' . " is existed.")
    else
        call execute('tabnew ' . l:fname) 
        call hjutils#add_fileheader()
        call setline(line('$') + 1, '')
        call setline(line('$') + 1, '')
        call setline(line('$') + 1, 'let s:filename = fnamemodify(expand("<sfile>"), ":t:r")')
        call setline(line('$') + 1, '')
        call setline(line('$') + 1, 'let s:pluginfo = {')
        call setline(line('$') + 1, '            \ "cmdline" : [')
        call setline(line('$') + 1, '                        \ ],')
        call setline(line('$') + 1, '            \ "mode"    : "ignore",')
        call setline(line('$') + 1, '            \ "func"    : ["Init_"],')
        call setline(line('$') + 1, '            \}')
        call setline(line('$') + 1, '')
        call setline(line('$') + 1, 'function! Pluginfo_()')
        call setline(line('$') + 1, '    return s:pluginfo')
        call setline(line('$') + 1, 'endfunction')
        call setline(line('$') + 1, '')
        call setline(line('$') + 1, 'function! Init_()')
        call setline(line('$') + 1, 'endfunction')
        call setline(line('$') + 1, '')

    endif
endfunction

"----------------------------------------------------------------------
" 此函数在vim terminal中调用用来打开某个文件
" 为drop功能使用
" 从vim-terminal-help移植过来
" 
"----------------------------------------------------------------------
function! Tapi_TerminalEdit(bid, arglist)
    let name = (type(a:arglist) == v:t_string)? a:arglist : a:arglist[0]
    let cmd = get(g:, 'terminal_edit', 'tab drop')
    silent exec cmd . ' ' . fnameescape(name)
    return ''
endfunction


"----------------------------------------------------------------------
" enable alt key in terminal vim
"----------------------------------------------------------------------
function! hjutils#enable_altkey()
    if has('nvim') == 0 && has('gui_running') == 0
        set ttimeout
        if $TMUX != ''
            set ttimeoutlen=35
        elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
            set ttimeoutlen=85
        endif
        function! s:meta_code(key)
            if get(g:, 'terminal_skip_key_init', 0) == 0
                exec "set <M-".a:key.">=\e".a:key
            endif
        endfunc
        for i in range(10)
            call s:meta_code(nr2char(char2nr('0') + i))
        endfor
        for i in range(26)
            call s:meta_code(nr2char(char2nr('a') + i))
            call s:meta_code(nr2char(char2nr('A') + i))
        endfor
        for c in [',', '.', '/', ';', '{', '}']
            call s:meta_code(c)
        endfor
        for c in ['?', ':', '-', '_', '+', '=', "'"]
            call s:meta_code(c)
        endfor
        function! s:key_escape(name, code)
            if get(g:, 'terminal_skip_key_init', 0) == 0
                exec "set ".a:name."=\e".a:code
            endif
        endfunc
        call s:key_escape('<F1>', 'OP')
        call s:key_escape('<F2>', 'OQ')
        call s:key_escape('<F3>', 'OR')
        call s:key_escape('<F4>', 'OS')
    endif
endfunction

function! hjutils#open_qf_file(type)
"  在新的tab中open quickfix的当前文件
    if &buftype != 'quickfix' " 判断当前buffer是不是quickfix
        return
    endif

    let l:list_index=line(".")-1 "获得光标位置所在的行数
    let l:list=getqflist()[l:list_index] "获得quickfix里面的当前行的内容,结果是一个字典

    "execute ':tabedit +' . l:list.lnum . " " . bufname(l:list.bufnr)
    execute a:type . l:list.lnum . " " . bufname(l:list.bufnr)
    "execute ':vertical belowright edit +' . l:list.lnum . " " . bufname(l:list.bufnr)
endfunction


