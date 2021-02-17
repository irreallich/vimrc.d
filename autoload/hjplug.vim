" VIM scripts
" Author: hjwang
" Created Time : 2019年10月14日 星期一 15时55分28秒
" File Name: autoload/hjplug.vim
" Description:
"""


function s:plug_init(plug) 

    " init and config the plugs
    call s:plug_run_func(a:plug)
    call s:plug_reg_hotkey(a:plug)
endfunction


function s:plug_reg_hotkey_fromdict(plugname,key,key_details) 
    let l:key_details = a:key_details
    if has_key(l:key_details,'cmdstart') == 0
        let  l:key_details.cmdstart = ''
    endif
    if has_key(l:key_details,'cmdend') == 0
        let  l:key_details.cmdend = ''
    endif
    call hjutils#set_hotkey(a:key,l:key_details.cmdstart,l:key_details.cmdend,
        \a:plugname,l:key_details.desc)
endfunction

function s:plug_reg_hotkey(plug) 
    if has_key(a:plug,'hotkeys') == 0  || len(keys(a:plug.hotkeys)) == 0
        return
    endif
    for l:key in keys(a:plug.hotkeys)
        let l:key_details = a:plug.hotkeys[l:key]
        if type(l:key_details) == v:t_dict
            call s:plug_reg_hotkey_fromdict(a:plug.name,l:key,l:key_details)
        endif
        " 针对一个键在多种不同模式下相应的问题
        if type(l:key_details) == v:t_list
            for l:details in l:key_details
                call s:plug_reg_hotkey_fromdict(a:plug.name,l:key,l:details)
            endfor
        endif
    endfor
endfunction

function s:plug_run_func(plug) 
    if len(a:plug.func)
        for l:func in a:plug.func 
            exec 'call ' . l:func . '()'
        endfor
    endif
endfunction

function! s:checkplug() 
    if !filereadable($VIMFILES.'/autoload/plug.vim')
        if env#Executable('curl') && env#Executable('git')
            if env#IsWindows()
                silent! exec ':!curl -fLo ' . $VIMFILES.'\\autoload'.'\\plug.vim ' .
                    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
            else
                silent! exec ':!curl -fLo ' . $VIMFILES.'/autoload'.'/plug.vim ' .
                    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
            endif
        else
            call hjutils#logs(g:log_level_error,expand('<sfile>') . ':'.expand('<slnum>') .':'. "need curl!!")
        endif
    endif
endfunction

function! s:get_vimplug_cmd(cmdlist,plugmode) 

    let l:sq = "\'"
    let l:temp = ''  

    for l:num in range(len(a:cmdlist))
        if l:num == 0
            let l:temp = 'Plug ' . l:sq .a:cmdlist[l:num] . l:sq . ' ,{'  
        else
            let l:temp = l:temp . a:cmdlist[l:num] . ',' 
        endif
    endfor

    if a:plugmode == 'normal'
        if matchstr(l:temp,"'on':")  == "'on':" 
        else
            let l:temp = l:temp . "'on': [],"
        endif
    endif
    let l:temp = l:temp . '}'

    return l:temp
endfunction

function! s:load_plug_by_mode(plugs,plug_mode) 
    for l:key in keys(a:plugs)
        let l:plug = a:plugs[l:key]
        if has_key(l:plug,'mode') == 1 && l:plug.mode ==# a:plug_mode && has_key(l:plug,'loaded') == 0
            if has_key(l:plug,'cmdline') == 1 && len(l:plug.cmdline) != 0
                for l:cmdlist in l:plug.cmdline
                    " add plug to vim-plug init_list
                    execute s:get_vimplug_cmd(l:cmdlist,a:plug_mode) 
                endfor
            endif

            if l:plug.mode == 'auto' || l:plug.mode == 'pre' || l:plug.mode == 'cmd'
                call s:plug_init(l:plug)
                let l:plug.loaded = 1
            else
                let l:plug.loaded = 0
            endif
        else
            if has_key(l:plug,'mode') == 0
                call hjutils#logs(g:log_level_error, 
                    \ expand('<sfile>'). ':'.expand('<slnum>') . ':'. l:plug.name . " missing mode !!")
            else
                call hjutils#logs(g:log_level_warning, 
                    \ expand('<sfile>'). ':'.expand('<slnum>') . ':'. l:plug.name . " mode not matched!!")
            endif
        endif
    endfor
endfunction

function! hjplug#preload_by_vimplug(path,plugs) 
    " this function is based on vim-plug
    if filereadable($VIMFILES.'/autoload/plug.vim')
        call plug#begin(a:path)
        for l:order in hjinit#get('sys','plug_load_order') 
            call s:load_plug_by_mode(a:plugs,l:order) 
        endfor
        call plug#end()
    else
        call hjutils#logs(g:log_level_error,expand('<sfile>') . ':'.expand('<slnum>') .':'.'need vim-plug')
    endif
endfunction

function! hjplug#set_plug_mode(plug,mode) 
    let l:plugs = hjinit#get('var','plugs')
    let l:plug =  get(l:plugs,a:plug)
    if type(l:plug) == v:t_dict
        let l:plug.mode = a:mode
    else
        call hjutils#logs(g:log_level_warning, expand('<sfile>'). ':'.expand('<slnum>') . ':'. a:plug . " was not existed!")
    endif
endfunction

function! hjplug#run_plug(plug) 
    let l:plugs = hjinit#get('var','plugs')
    let l:plug =  get(l:plugs,a:plug)
    if  has_key(l:plug,'mode') == 1
        if l:plug.mode == 'ignore'
            return
        endif
        if  l:plug.loaded == 0
            " plug#load function need a list as input argument
            for l:cmd in l:plug.cmdline
                call plug#load(split(l:cmd[0],'/')[1])
            endfor
            call s:plug_init(l:plug)
            let l:plug.loaded = 1
        else
            call hjutils#logs(g:log_level_warning, expand('<sfile>'). ':'.expand('<slnum>') . ':'. l:plug.name . " was loaded!!")
        endif
    endif
endfunction

function! hjplug#init(plugs,path,ext_name) 
    " vim中变量无法使用-，所有一些插件名包含'-'和'.'的我用_代替
    " 这是配置文件名和插件名不一样的原因
    if !exists('a:plugs')
        execute 'let '. a:plugs . '={}'
    endif
    let l:namelist = split(globpath(a:path,'*.' . a:ext_name))
    for l:name in l:namelist
        execute 'source '.l:name
        let l:firstname = fnamemodify(l:name,':t:r')
        " since I can't use '-' char to file name in vim script
        execute 'let a:plugs.' . l:firstname . ' = {}' 

        let l:funcname = 'Pluginfo_' . l:firstname
        if exists('*' . l:funcname)
            execute 'let l:pluginfo = ' . l:funcname . '()'
        else
            execute 'let l:pluginfo = {}' 
        endif
        execute 'let a:plugs.' . l:firstname . ' = l:pluginfo' 
        execute 'let l:plug = a:plugs.' . l:firstname  
        " set name field by cmdline
        if has_key(l:plug,'cmdline') == 1 && has_key(l:plug,'name') == 0
            if len(l:plug.cmdline) != 0 
                let l:plug.name = split(l:plug.cmdline[0][0],'/')[1] 
            else 
                let l:plug.name = l:firstname 
            endif 
        endif

        " 由于有些脚本会在source的时候直接进行初始化
        " 由此导致自己的配置不能生效
        " 所以一些配置在source我们的配置脚本的时候直接设置
        let l:prefunc = 'Pre_' . l:firstname . '_init'
        if exists('*'.l:prefunc)
            execute 'call '.l:prefunc . '()'
        endif

    endfor
endfunction
