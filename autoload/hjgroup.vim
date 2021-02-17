" VIM scripts
" Author: hjwang
" Created Time : 2019年10月14日 星期一 15时52分25秒
" File Name: /home/hjwang/work/config/vimrc.d/autoload/hjgroup.vim
" Description:
"""

let s:filename = fnamemodify(expand('<sfile>'), ':t:r')

function! hjgroup#init(var,path,ext_name) 
    " path : feature config file path
    " ext_name: plug config file name,not plug name
    let l:namelist = split(globpath(a:path,'*.' . a:ext_name))
    for l:name in l:namelist
        execute 'source '.l:name
        let l:firstname = fnamemodify(l:name,':t:r')
        let l:funcname = 'Default_group_' . l:firstname
        if exists('*' . l:funcname)
            execute 'call ' . l:funcname . '()'
        endif
    endfor
    call s:init_plug_bymode('pre')
    call s:init_plug_bymode('ignore')
endfunction

function! s:init_plug_bymode(mode) 
    " 依据记录的list，将plug的mode设置成相应的值
    " auto 自动加载， ignore 不加载
    let l:groups= hjinit#get('var','groups')
    let l:plugs = hjinit#get('var','plugs')
    let l:pluglist = []
    let l:special_list = hjinit#get('sys',a:mode . '_plug_list')

    for l:val1 in values(l:groups)
        for l:val2 in values(l:val1)
            for l:val3 in keys(l:val2)
                call add(l:pluglist,l:val3) 
            endfor
        endfor
    endfor
    call sort(uniq(l:pluglist))
    for l:val in l:pluglist 
        if len(l:special_list) != 0 && index(l:special_list,l:plugs[l:val].name) != -1
            call hjplug#set_plug_mode(l:val,a:mode)
        endif
    endfor
endfunction

function! hjgroup#set(group,feature,plug) 
    " group: group name
    " feature: feature name
    " plug: plug name ,'default' means: load all plugs in the feature 
    let l:groups= hjinit#get('var','groups')
    let l:features = hjinit#get('var','features')
    let l:plugs = hjinit#get('var','plugs')
    " check plug
    if a:plug != 'default' && !has_key(l:plugs ,a:plug)  
        call hjutils#logs(g:log_level_error,  expand('<sfile>') . ':'.expand('<slnum>') .':'. 'plug ' . a:plug.' is not existed ' )
        return
    endif
 
    let l:var = get(l:features,a:feature,'error')
    if type(l:var) == type('') && l:var == 'error'
        call hjutils#logs(g:log_level_error,  expand('<sfile>') . ':'.expand('<slnum>') .':'.'feature ' . a:feature .' is not existed ' )
        return
    endif

    if !has_key(l:groups,a:group)
        execute 'let l:groups.' . a:group. ' = {}'
    endif
    execute 'let l:temp = ' . 'l:groups.' .a:group

    if a:plug == 'default'
        let l:temp[a:feature] = l:var
    else
        let l:var = get(l:plugs,a:plug,'error')
        if type(l:var) == type('') && l:var == 'error'
            call hjutils#logs(g:log_level_error,  expand('<sfile>') . ':'.expand('<slnum>') .':'.'feature ' . a:plug .' is not existed ' )
            return
        endif
        let l:temp[a:feature] = {}
        let l:temp[a:feature][a:plug] = l:var['name']
    endif
endfunction

function! hjgroup#run_group(group) 
    for l:feature in items(a:group)
        call hjfeature#run_feature(l:feature)
    endfor
endfunction




