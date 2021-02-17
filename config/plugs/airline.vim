" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时20分11秒
" File Name: config/plug_conf/airline.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
\ 'cmdline' : [
\   ['vim-airline/vim-airline'],
\   ['vim-airline/vim-airline-themes'],
\   ],
\ 'mode'    : 'normal',
\ 'func'    : ['Init_airline'],
\}
function! Pluginfo_airline()
    return s:pluginfo 
endfunction


function! Init_airline()
    call s:airline_init()            
    call s:airline_extensions()
    "call s:airline_autocmd()
endfunction 

function! s:airline_init()
    let b:airline_whitespace_disabled = 1

    let g:airline_powerline_fonts = 1
    "let g:airline_theme='papercolor'
    let g:airline_theme=s:get_themes_name('papercolor')
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_filetype_overrides = {
    \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
    \ 'help':  [ 'Help', '%f' ],
    \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
    \ 'startify': [ 'startify', '' ],
    \ 'vim-plug': [ 'Plugins', '' ],
    \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
    \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
    \ }


endfunction    

function! s:airline_extensions()
    "let g:airline_extensions = []  " 关闭所有airline 插件
    "let g:airline_section_warning='%{strftime("%m/%d\-%H:%M")}'

    " for tabline
    let g:airline#extensions#tabline#enabled = 1 

    " 显示tab number
    let g:airline#extensions#tabline#show_tab_nr = 1
    let g:airline#extensions#tabline#tab_nr_type = 1        " 显示tab编号
    let g:airline#extensions#tabline#tabnr_formatter = 'Hj_airline_tablenr_formatter'
    let g:airline#extensions#tabline#tabtitle_formatter = 'Hj_airline_tabline_title'

    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:airline#extensions#tabline#fnamecollapse = 2
    let g:airline#extensions#tabline#show_buffers = 1       " 如果只有一个tab时,tabline上显示buffer名字
    let g:airline#extensions#tabline#buf_label_first = 1    " 将上面的buffer显示在左边
    let g:airline#extensions#tabline#fnamemod = ':p:t'      " tab中仅显示文件名
    let g:airline#extensions#tabline#show_splits = 0        " tabline右侧不显示没用的文件信息
    "let g:airline#extensions#tabline#alt_sep = 0   " 没弄明白

    " 相应的插件能显示正常的tabline
    let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'


    if hjinit#get('sys','tag_bar') == 'tagbar'
        let g:airline#extensions#tagbar#enabled = 1
    endif

    " for ale
    let g:airline#extensions#ale#enabled = 1
    let airline#extensions#ale#error_symbol = 'E:'
    let airline#extensions#ale#warning_symbol = 'W:'
    let airline#extensions#ale#show_line_numbers = 1
    let airline#extensions#ale#open_lnum_symbol = '(L'
    let airline#extensions#ale#close_lnum_symbol = ')'

    " for vim-bookmark
    let g:airline#extensions#bookmark#enabled = 1

    " for git
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#hunks#enabled = 1  " 给vim-signify使用


    " for coc
    if hjinit#get('sys','complete') == 'coc'
        let g:airline#extensions#coc#enabled = 1
    endif

    " for ycm
       if hjinit#get('sys','complete') == 'youcompleteme'
        let g:airline#extensions#ycm#enabled = 1
    endif

 
    " for gutentags 
    let g:airline#extensions#gutentags#enabled = 1

    " 禁止从rtp中搜索extensions,关闭此项会导致win下报错 
    let g:airline#extensions#disable_rtp_load = 1


endfunction


function! s:airline_autocmd()
    augroup MyGutentagsStatusLineRefresher
        autocmd!
        autocmd User GutentagsUpdate call airline#update_statusline()
    augroup END
endfunction


function! Hj_airline_tablenr_formatter(tab_nr_type,nr)
    " 用来在tabline上显示本tab中开了少个窗口
    let spc=g:airline_symbols.space

    if (len(tabpagebuflist(a:nr)) > 1)
        return spc. a:nr. '.[%{tabpagewinnr('.a:nr.')}/%{len(tabpagebuflist('.a:nr.'))}]'
    else
        return spc. a:nr
    endif
endfunction

function! Hj_airline_tabline_title(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let bufnr = buflist[winnr - 1]
    let name = bufname(bufnr)

    if empty(name)
        if getqflist({'qfbufnr' : 0}).qfbufnr == bufnr
            let title = airline#extensions#tabline#formatters#default#wrap_name(bufnr, '[Quickfix List]')
        elseif win_getid(tabpagewinnr(a:n), a:n) && getloclist(win_getid(tabpagewinnr(a:n), a:n), {'qfbufnr' : 0}).qfbufnr == bufnr
            let title = airline#extensions#tabline#formatters#default#wrap_name(bufnr, '[Location List]')
        else
            let title = airline#extensions#tabline#formatters#default#wrap_name(bufnr, '[No Name]')
        endif
    else
        if name =~ 'term://'
            " Neovim Terminal
            let tail = substitute(name, '\(term:\)//.*:\(.*\)', '\1 \2', '')
        else
            let tail = fnamemodify(name, ':s?/\+$??:t')
        endif
        let title = airline#extensions#tabline#formatters#default#wrap_name(bufnr, tail)
    endif

    return title != '' ? title : airline#extensions#tabline#formatters#default#format(bufnr, buflist)
endfunction


function! s:get_themes_name(default)
    let l:themes =  hjinit#get('sys','status_line_themes')
    if l:themes  != 'auto'
        return l:themes
    endif

    let l:themes =  hjinit#get('sys','themes')
    if l:themes.colorscheme == 'ayu'
        return 'ayu_'.l:themes.background 
    elseif l:themes.colorscheme == 'one'
        return 'onedark'
    elseif l:themes.colorscheme == 'gruvbox'
        "return 'gruvbox'
        return 'base16_gruvbox_dark_hard'
    elseif l:themes.colorscheme == 'solarized8'
        return 'solarized'
    elseif l:themes.colorscheme == 'nord'
        return 'base16_nord'
    endif 

    return a:default
endfunction

