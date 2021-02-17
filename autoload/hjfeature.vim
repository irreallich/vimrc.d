" VIM scripts
" Author: hjwang
" Created Time : 2019年10月14日 星期一 14时36分06秒
" File Name: autoload/hjfeature.vim
" Description:
"""

function! hjfeature#init(var,path,ext_name) 
    " path : feature config file path
    " ext_name: plug config file name,not plug name
    let l:namelist = split(globpath(a:path,'*.' . a:ext_name))
    for l:name in l:namelist
        execute 'source '.l:name
        let l:firstname = fnamemodify(l:name,':t:r')
        let l:funcname = 'Default_feature_' . l:firstname
        if exists('*' . l:funcname)
            execute 'call ' . l:funcname . '()'
        endif
    endfor
endfunction

function! hjfeature#set(feature,plugname,act) 
    " var global features var name
    " feature: file first name feature
    " plugname: plug config file name,not plug name
    " act: 
    " act = 1 means on
    " act = others means off
    let l:features = hjinit#get('var','features')
    let l:plugs = hjinit#get('var','plugs')

    let l:var = get(l:plugs,a:plugname,'error')
    if type(l:var) == type('') && l:var == 'error'
        call hjutils#logs(g:log_level_warning,expand('<sfile>') . ':'.expand('<slnum>') .':'. "miss plug " .a:plugname . 'in the pluglist')
    else
        if !has_key(l:features,a:feature)
            execute 'let l:features.' . a:feature . ' = {}'
        endif
        execute 'let l:temp = ' . 'l:features.' .a:feature
        if a:act == 1
            let l:temp[a:plugname] = l:var.name
        else
            if has_key(l:temp,a:plugname) == 1
                call remove(l:temp,a:plugname)
            endif
            if len(l:temp) == 0
                call remove(l:features,a:feature) 
            endif
        endif
    endif
endfunction

function! hjfeature#run_feature(feature) 
    for l:plug in keys(a:feature[1])
        call hjplug#run_plug(l:plug)
    endfor
endfunction


