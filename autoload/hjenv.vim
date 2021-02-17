" init the vim environment
let s:is_unix     = (has('mac') || has('osx')) + has('unix')
let s:is_win      = has('win32') + has('win64')
let s:is_nvim     = has('nvim')
let s:is_gui      = has('gui_running') + has('gui_macvim')
let s:has_python3 = has('python3')
let s:has_python  = has('python')
let s:python_ver  = s:has_python+s:has_python3
let s:ycm_dependency = has('patch-7.4.1578')
let s:is_tmux = empty($TMUX)
let s:has_display = empty($DISPLAY)
let s:support_cscope=has('cscope')+executable('cscope')

function! hjenv#IsVim8() abort
    if v:version >= 800 && !s:is_nvim
        return 1
    else
        return 0
    endif
endfunction

function! hjenv#IsMac() abort
    if s:is_unix == 2 | return 1 | endif
    return 0
endfunction

function! hjenv#IsLinux() abort
    if s:is_unix == 1 | return 1 | endif
    return 0
endfunction

function! hjenv#IsWindows() abort
    if s:is_win | return 1 | endif
    return 0
endfunction

function! hjenv#IsWin64() abort
    if s:is_win == 2 | return 1 | endif
endfunction

function! hjenv#IsWin32() abort
    if s:is_win == 1 | return 1 | endif
    return 0
endfunction

function! hjenv#IsNvim() abort
    if s:is_nvim | return 1 | endif
    return 0
endfunction

function! hjenv#IsGui() abort
    if s:is_gui | return 1 | endif
    return 0
endfunction

function! hjenv#IsMacVim() abort
    if s:is_gui == 2 | return 1 | endif
    return 0
endfunction

function! hjenv#SupportPy2() abort
    if s:has_python | return 1 |endif
    return 0
endfunction

function! hjenv#SupportPy3() abort
    if s:has_python3 | return 1 |endif
    return 0
endfunction

function! hjenv#SupportPy() abort
    if s:python_ver | return 1 | endif
    return 0
endfunction

function! hjenv#SupportYcm() abort
    if s:ycm_dependency && s:python_ver | return 1 | endif
    return 0
endfunction

function! hjenv#IsTmux() abort
    if  s:is_tmux
        return 0
    endif
    return 1
endfunction

function! hjenv#IsDisplay() abort
    if  s:has_display
        return s:is_win
    endif
    return 1
endfunction

function! hjenv#IsUnix() abort
    if s:is_unix | return 1 | endif
    return 0
endfunction

function! hjenv#SupportAsync() abort
    if s:is_nvim || v:version >= 800 | return 1 | endif
    return 0
endfunction


function! hjenv#SupportCscope() abort
    if s:support_cscope == 2 | return 1 | endif
    return 0
endfunction

function! hjenv#Executable(exe) abort
    return executable(a:exe)
endfunction

function! hjenv#SupportTimer() abort
    return has('timers')
endfunction

function! hjenv#SupportTerminal() abort
    return hjenv#IsNvim() || (has('patch-8.0.1108') && has('terminal'))
endfunction

function! hjenv#SupportFeature(feature_name) abort
    return has(a:feature_name)
endfunction

function! hjenv#check_requirement() abort
    if v:version > 703
        return 1
    elseif v:version ==_ 703
        return has('patch1058')
    else
        return 0
    endif
endfunction

function! hjenv#get_termwinkey() abort
    if has('patch-8.0.1743')
        return &termwinkey
    else
        return &termkey
    endif
endfunction
