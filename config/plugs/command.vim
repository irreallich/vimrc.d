" VIM scripts
" Author: hjwang
" Created Time : 2019年08月22日 星期四 16时02分05秒
" File Name: config/plug_conf/command.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_command'],
            \}
function! Pluginfo_command()
    return s:pluginfo 
endfunction

function! Init_command()
    "使用customlist返回的时候无法自动根据首字母过滤返回的内容，所以尽量使用custom来自动填充参数
    command! -complete=custom,s:hj_groups       -nargs=? Confg  call hjutils#edit('group',<q-args>) 
    command! -complete=custom,s:hj_features     -nargs=? Conff  call hjutils#edit('feature',<q-args>) 
    command! -complete=custom,s:hj_plugs        -nargs=? Confp  call hjutils#edit('plug',<q-args>) 
    command! -complete=custom,s:hj_custom       -nargs=* Conf   call hjutils#edit('all',<q-args>)
    command! -complete=custom,s:hj_help -nargs=? Hjhelp call hjutils#help(<q-args>) 

    command! -complete=custom,s:hj_helpdoc -nargs=? Doct call hjutils#openfile('tabe',globpath(hjinit#get('path','help_doc') , <q-args>)) 
    command! -complete=custom,s:hj_helpdoc -nargs=? Docv call hjutils#openfile('vs',globpath(hjinit#get('path','help_doc') , <q-args>)) 
    command! -nargs=* -complete=help Hv vertical belowright help <args>
    command! -nargs=* -complete=help Tv vertical belowright terminal<args>
    command! -nargs=* -complete=help Tt tab terminal<args>
    " 有时语法高亮会突然失效,设置命令重新加载语法高亮
    command! -nargs=* -complete=help Ssync :syn off | syn on
    command! -nargs=* -complete=help Hjaddheader call hjutils#add_fileheader() 

    " 尝试kill所有打开的term,不明白为啥失败
    command! -bar -nargs=0 TermKall       :call map(term_list(), { i,x -> job_stop(term_getjob(x)) })



    if hjenv#IsWindows() "for wsl
        command -nargs=* -complete=help Wslv vertical belowright terminal ubuntu1804.exe <args>
        command -nargs=* -complete=help Wslt tab terminal ubuntu1804.exe <args>
        command -nargs=* -complete=help Wsl terminal ubuntu1804.exe <args>
    endif

endfunction


function! s:hj_custom(A,L,P)
    let l:groups = hjinit#get('var','groups')
    let l:ret = []
    let l:pluglist = []
   
    let l:arglist = split(a:L)
    let l:argnum = len(l:arglist)
    
    if l:argnum == 1 " for none arg
        return join(keys(l:groups), "\n")
    elseif l:argnum == 2  
        if has_key(l:groups,l:arglist[1]) 
            return join(keys(get(l:groups,l:arglist[1])), "\n")
        else
            let l:grouplist = keys(l:groups)
            for l:str in l:grouplist
                if match(l:str,l:arglist[1]) != -1
                    call add(l:ret, l:str) 
                endif
            endfor
            return join(l:ret , "\n")
        endif
    elseif l:argnum == 3 && has_key(l:groups[l:arglist[1]],l:arglist[2]) 
        let l:feature = get(l:groups[l:arglist[1]],l:arglist[2])
        echo l:feature
        for l:plug in keys(l:feature) 
            call add(l:pluglist , l:plug) 
        endfor
        return join(l:pluglist , "\n") 
    else 
        return ''
    endif
endfunction

function! s:hj_custom_list(A,L,P)
    let l:groups = hjinit#get('var','groups')
    let l:ret = []
    let l:pluglist = []
   
    let l:arglist = split(a:L)
    let l:argnum = len(l:arglist)
    
    if l:argnum == 1 " for none arg
        return keys(l:groups)
    elseif l:argnum == 2  
        if has_key(l:groups,l:arglist[1]) 
            return keys(get(l:groups,l:arglist[1]))
        else
            let l:grouplist = keys(l:groups)
            for l:str in l:grouplist
                if match(l:str,l:arglist[1]) != -1
                    call add(l:ret, l:str) 
                endif
            endfor
            return l:ret            
        endif
    elseif l:argnum == 3 && has_key(l:groups[l:arglist[1]],l:arglist[2]) 
        let l:feature = get(l:groups[l:arglist[1]],l:arglist[2])
        echo l:feature
        for l:plug in keys(l:feature) 
            call add(l:pluglist , l:plug) 
        endfor
        return l:pluglist 
    else 
        return []
    endif
endfunction

function! s:hj_groups(A,L,P)
    " this function is used for -complete=custom
    let l:value = hjinit#get('var','groups')
    let l:ret = keys(l:value)
    return join(l:ret, "\n")
endfunction

function! s:hj_features(A,L,P)
    " this function is used for -complete=custom
    let l:value = hjinit#get('var','features')
    let l:ret = keys(l:value)
    return join(l:ret, "\n")
endfunction
function! s:hj_plugs(A,L,P)
    " this function is used for -complete=custom
    let l:value = hjinit#get('var','plugs')
    let l:ret = keys(l:value)
    return join(l:ret, "\n")
endfunction

function! s:hj_plugs_list(A,L,P)
    " this function is used for -complete=customlist
    let l:value = hjinit#get('var','plugs')
    let l:ret = keys(l:value)
    return ret

endfunction

function! s:hj_help(A,L,P)
    " this function is used for -complete=customlist
    let l:values = hjinit#get('var','help_keymap')
    let l:ret =  keys(l:values)
    "call uniq(sort(l:ret))
    return join(l:ret, "\n")
endfunction

function! s:hj_helpdoc(A,L,P)
    " this function is used for -complete=customlist
    return join(readdir(hjinit#get('path','help_doc')),"\n")
endfunction




