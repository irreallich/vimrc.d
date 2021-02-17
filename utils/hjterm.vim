" VIM scripts
" Author: hjwang
" Created Time : 2020年09月02日 星期三 10时25分04秒
" File Name: /home/hjwang/work/config/vimrc.d/utils/hjterm.vim
" Description:
" 基于skywind3000的vim-terminal-help修改
"  
" 
"""

"----------------------------------------------------------------------
" check compatible
"----------------------------------------------------------------------
if has('patch-8.1.1') == 0 && has('nvim') == 0
    finish
endif


"----------------------------------------------------------------------
" configuration
"----------------------------------------------------------------------

" initialize shell directory
" 0: vim's current working directory (which :pwd returns)
" 1: file path of current file.
" 2: project root of current file.
if !exists('g:terminal_cwd')
    let g:terminal_cwd = 1
endif

" root markers to identify the project root
if !exists('g:terminal_rootmarkers')
    let g:terminal_rootmarkers = ['.git', '.svn', '.project', '.root', '.hg']
endif


"----------------------------------------------------------------------
" Initialize
"----------------------------------------------------------------------
let $VIM_SERVERNAME = v:servername
let $VIM_EXE = v:progpath
let s:windows = has('win32') || has('win64') 

" setup PATH for utils
"if stridx($PATH, s:script) < 0
"    if s:windows == 0
"        let $PATH .= ':' . s:script
"    else
"        let $PATH .= ';' . s:script
"    endif
"endif
"

"----------------------------------------------------------------------
" internal utils
"----------------------------------------------------------------------

" returns nearest parent directory contains one of the markers
function! s:find_root(name, markers, strict)
    let name = fnamemodify((a:name != '')? a:name : bufname(), ':p')
    let finding = ''
    " iterate all markers
    for marker in a:markers
        if marker != ''
            " search as a file
            let x = findfile(marker, name . '/;')
            let x = (x == '')? '' : fnamemodify(x, ':p:h')
            " search as a directory
            let y = finddir(marker, name . '/;')
            let y = (y == '')? '' : fnamemodify(y, ':p:h:h')
            " which one is the nearest directory ?
            let z = (strchars(x) > strchars(y))? x : y
            " keep the nearest one in finding
            let finding = (strchars(z) > strchars(finding))? z : finding
        endif
    endfor
    if finding == ''
        return (a:strict == 0)? fnamemodify(name, ':h') : ''
    endif
    return fnamemodify(finding, ':p')
endfunc

" returns project root of current file
function! s:project_root()
    let name = expand('%:p')
    return s:find_root(name, g:terminal_rootmarkers, 0)
endfunc


"----------------------------------------------------------------------
" open a new/previous terminal
"----------------------------------------------------------------------
function! TerminalOpen(...)
    let bid = get(t:, '__terminal_bid__', -1)
    let pos = get(g:, 'terminal_pos', 'rightbelow')
    let height = get(g:, 'terminal_height', 10)
    let succeed = 0
    function! s:terminal_view(mode)
        if a:mode == 0
            let w:__terminal_view__ = winsaveview()
        elseif exists('w:__terminal_view__')
            call winrestview(w:__terminal_view__)
            unlet w:__terminal_view__
        endif
    endfunc
    let uid = win_getid()
    keepalt noautocmd windo call s:terminal_view(0)
    keepalt noautocmd call win_gotoid(uid)
    if bid > 0
        let name = bufname(bid)
        if name != ''
            let wid = bufwinnr(bid)
            if wid < 0
                exec pos . ' ' . height . 'split'
                exec 'b '. bid
                if mode() != 't'
                    if has('nvim')
                        startinsert
                    else
                        exec "normal! i"
                    endif
                endif
            else
                exec "normal! ". wid . "\<c-w>w"
            endif
            let succeed = 1
        endif
    endif
    if has('nvim')
        let cd = haslocaldir()? 'lcd' : (haslocaldir(-1, 0)? 'tcd' : 'cd')
    else
        let cd = haslocaldir()? ((haslocaldir() == 1)? 'lcd' : 'tcd') : 'cd'
    endif
    if succeed == 0
        let shell = get(g:, 'terminal_shell', '')
        let command = (shell != '')? shell : &shell
        let close = get(g:, 'terminal_close', 0)
        if has('nvim') && 0
            for ii in range(winnr('$') + 8)
                let info = nvim_win_get_config(0)
                if has_key(info, 'anchor') == 0
                    break
                endif
                keepalt noautocmd exec "normal! \<c-w>w"
            endfor
            let uid = win_getid()
        endif
        let savedir = getcwd()
        if &bt == ''
            if g:terminal_cwd == 1
                let workdir = (expand('%') == '')? getcwd() : expand('%:p:h')
                silent execute cd . ' '. fnameescape(workdir)
            elseif g:terminal_cwd == 2
                silent execute cd . ' '. fnameescape(s:project_root())
            endif
        endif
        if has('nvim') == 0
            exec pos . ' ' . height . 'split'
            let opts = {'curwin':1, 'norestore':1, 'term_finish':'open'}
            let opts.term_kill = get(g:, 'terminal_kill', 'term')
            let opts.exit_cb = function('s:terminal_exit')
            let bid = term_start(command, opts)
            setlocal nonumber norelativenumber signcolumn=no
            let jid = term_getjob(bid)
            let b:__terminal_jid__ = jid
        else
            exec pos . ' ' . height . 'split'
            exec 'enew'
            let opts = {}
            let opts.on_exit = function('s:terminal_exit')
            let jid = termopen(command, opts)
            setlocal nonumber norelativenumber signcolumn=no
            let b:__terminal_jid__ = jid
            startinsert
        endif
        silent execute cd . ' '. fnameescape(savedir)
        let t:__terminal_bid__ = bufnr('')
        setlocal bufhidden=hide
        if get(g:, 'terminal_list', 1) == 0
            setlocal nobuflisted
        endif
        if get(g:, 'terminal_auto_insert', 0) != 0
            if has('nvim') == 0
                autocmd WinEnter <buffer> exec "normal! i"
            else
                autocmd WinEnter <buffer> startinsert
            endif
        endif
    endif
    let x = win_getid()
    noautocmd windo call s:terminal_view(1)
    noautocmd call win_gotoid(uid)    " take care of previous window
    noautocmd call win_gotoid(x)
    if get(g:, 'terminal_fixheight', 0)
        setlocal winfixheight
    endif
endfunc


"----------------------------------------------------------------------
" hide terminal
"----------------------------------------------------------------------
function! TerminalClose()
    let bid = get(t:, '__terminal_bid__', -1)
    if bid < 0
        return
    endif
    let name = bufname(bid)
    if name == ''
        return
    endif
    let wid = bufwinnr(bid)
    if wid < 0
        return
    endif
    let sid = win_getid()
    noautocmd windo call s:terminal_view(0)
    call win_gotoid(sid)
    if wid != winnr()
        let uid = win_getid()
        exec "normal! ". wid . "\<c-w>w"
        close
        call win_gotoid(uid)
    else
        close
    endif
    let sid = win_getid()
    noautocmd windo call s:terminal_view(1)
    call win_gotoid(sid)
    let jid = getbufvar(bid, '__terminal_jid__', -1)
    let dead = 0
    if has('nvim') == 0
        if type(jid) == v:t_job
            let dead = (job_status(jid) == 'dead')? 1 : 0
        endif
    else
        if jid >= 0
            try
                let pid = jobpid(jid)
            catch /^Vim\%((\a\+)\)\=:E900:/
                let dead = 1
            endtry
        endif
    endif
    if dead
        exec 'bdelete! '. bid
    endif
endfunc


"----------------------------------------------------------------------
" process exit callback
"----------------------------------------------------------------------
function! s:terminal_exit(...)
    let close = get(g:, 'terminal_close', 0)
    if close != 0
        let bid = get(t:, '__terminal_bid__', -1)
        let alive = 0
        if bid > 0 && bufname(bid) != ''
            let alive = (bufwinnr(bid) > 0)? 1 : 0
        endif
        if alive
            call TerminalClose()
        elseif bid > 0
            exec 'bdelete! '.bid
        endif
    endif
endfunc


"----------------------------------------------------------------------
" toggle open/close
"----------------------------------------------------------------------
function! TerminalToggle()
    let bid = get(t:, '__terminal_bid__', -1)
    let alive = 0
    if bid > 0 && bufname(bid) != ''
        let alive = (bufwinnr(bid) > 0)? 1 : 0
    endif
    if alive == 0
        call TerminalOpen()
    else
        call TerminalClose()
    endif
endfunc


"----------------------------------------------------------------------
" send text to terminal
"----------------------------------------------------------------------
function! TerminalSend(text)
    let bid = get(t:, '__terminal_bid__', -1)
    let alive = 0
    if bid > 0 && bufname(bid) != ''
        let wid = bufwinnr(bid)
        if wid > 0
            let alive = (bufname(bid) != '')? 1 : 0
        endif
    endif
    " check if buffer exists
    if alive
        " check if job stopped
        let jid = getbufvar(bid, '__terminal_jid__', -1)
        if has('nvim') == 0
            if type(jid) == v:t_job
                let alive = (job_status(jid) == 'dead')? 0 : 1
            endif
        else
            if jid >= 0
                try
                    let pid = jobpid(jid)
                catch /^Vim\%((\a\+)\)\=:E900:/
                    let alive = 0
                endtry
            endif
        endif
    endif
    let x = win_getid()
    if alive == 0
        call TerminalClose()
        call TerminalOpen()
        if has('nvim')
            stopinsert
        endif
    endif
    let bid = get(t:, '__terminal_bid__', -1)
    if bid > 0
        let jid = getbufvar(bid, '__terminal_jid__', '')
        if string(jid) != ''
            if has('nvim') == 0
                let ch = job_getchannel(jid)
                call ch_sendraw(ch, a:text)
            else
                call chansend(jid, a:text)
            endif
        endif
    endif
    if has('nvim')
        let bid = get(t:, '__terminal_bid__', -1)
        if bid > 0 && bufname(bid) != ''
            let wid = bufwinnr(bid)
            if wid > 0
                exec '' . wid . 'wincmd w'
            endif
            startinsert
            stopinsert
            exec 'normal! G'
        endif
    endif
    call win_gotoid(x)
endfunc


"----------------------------------------------------------------------
" can be called from internal terminal.
"----------------------------------------------------------------------
function! Tapi_TerminalEdit(bid, arglist)
    let name = (type(a:arglist) == v:t_string)? a:arglist : a:arglist[0]
    let cmd = get(g:, 'terminal_edit', 'tab drop')
    silent exec cmd . ' ' . fnameescape(name)
    return ''
endfunc


"----------------------------------------------------------------------
" drop a file and ask user to select a window for dropping if there
" are multiple modifiable windows
"----------------------------------------------------------------------
function! s:SelectiveDrop(filename)
    let modifiable_wins = []
    for i in range(1, winnr('$'))
        if expand('#' . winbufnr(i) . ':p') ==# fnamemodify(a:filename, ':p')
            execute i . 'wincmd w'
            return
        endif

        if getwinvar(i, '&modifiable')
            call add(modifiable_wins, i)
        endif
    endfor
    let escaped_filename = fnameescape(a:filename)
    if len(modifiable_wins) >= 2
        let key = char2nr('A')
        let saved_statuslines = {}
        let choices = []
        for i in modifiable_wins
            let saved_statuslines[i] = getwinvar(i, '&statusline')
            let c = nr2char(key)
            let w = winwidth(i)
            call setwinvar(i, '&statusline', '%#Search#' . repeat(' ', (w - 1) / 2) . c . repeat(' ', w - 1 - (w - 1) / 2))
            call add(choices, c)
            let key += 1
        endfor
        redraw
        echohl ModeMsg | echon 'Choose window (' . join(choices, '/') . '): ' | echohl None
        let choice_nr = getchar()
        let choice = index(choices, toupper(nr2char(choice_nr)))
        for [i, saved_statusline] in items(saved_statuslines)
            call setwinvar(i, '&statusline', saved_statusline)
        endfor
        if choice >= 0
            execute modifiable_wins[choice] . 'wincmd w'
            execute 'edit ' . escaped_filename
        endif
        redraw
        echon
    elseif len(modifiable_wins) == 1
        execute modifiable_wins[0] . 'wincmd w'
        execute 'edit ' . escaped_filename
    else
        execute 'split ' . escaped_filename
    endif
endfunction

command! -complete=file -nargs=1 SelectiveDrop call <SID>SelectiveDrop(<q-args>)


