" VIM scripts
" Author: hjwang
" Created Time : 2/14/2020 6:01:01 PM
" File Name: config\plugs\vim_dirvish.vim
" Description:
"""

" 在dirvish buffer中输入g? 可以调出帮助
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['justinmk/vim-dirvish'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_vim_dirvish'],
            \ 'hotkeys' :   {
            \               '<CR>':  {'desc': 'Opens file at cursor.'},
            \               '[count]R':  {'desc': 'Reloads the current directory. (|:edit| works too.)'},
            \               'gq ':  {'desc': 'Quits and returns to the original file.'},
            \               '-':  {'desc': 'Opens the [count]th parent directory.'},
            \               'o':  {'desc': 'Opens file in a new window.'},
            \               'a':  {'desc': 'Opens file in a new, vertical window.'},
            \               '{Visual}A':  {'desc': 'Opens each selected file in a new, vertical window.'},
            \               'K':  {'desc': 'Shows file info. [count] shows directory size.'},
            \               '{Visual}K':  {'desc': 'Shows info for selected files. [count] shows directory size.'},
            \               'p':  {'desc': 'Previews file at cursor.'},
            \               'CTRL-N':  {'desc': 'Previews the next file.'},
            \               'CTRL-P':  {'desc': 'Previews the previous file.'},
            \               'x':  {'desc': 'Adds/removes file to/from the local |arglist|.'},
            \               '{Visual}x':  {'desc': 'Adds selected files to the local arglist.'},
            \               'dax':  {'desc': 'Starts a new empty local arglist.'},
            \               '.':  {'desc': 'Inserts ":! {path}" into the command-line.'},
            \               '{Visual}.':  {'desc': 'Inserts "|:Shdo|  {}" into the command-line.'},
            \               '[count].':  {'desc': 'Inserts "|:Shdo|! {}" into the command-line.'},
            \               }
            \}
function! Pluginfo_vim_dirvish()
    return s:pluginfo
endfunction


function! s:setup_dirvish()
    " Dirvish 设置：自动排序并隐藏文件，同时定位到相关文件
    " 将目录排在前面，文件排在后面，并且按照字母顺序排序
    if &buftype != 'nofile' && &filetype != 'dirvish'
        return
    endif
    if has('nvim')
        return
    endif
    " 取得光标所在行的文本（当前选中的文件名）
    let text = getline('.')
    if ! get(g:, 'dirvish_hide_visible', 0)
        exec 'silent keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
    endif
    " 排序文件名
    exec 'sort ,^.*[\/],'
    let name = '^' . escape(text, '.*[]~\') . '[/*|@=|\\*]\=\%($\|\s\+\)'
    " 定位到之前光标处的文件
    call search(name, 'wc')
    noremap <silent><buffer> ~ :Dirvish ~<cr>
    noremap <buffer> % :e %
endfunc

function! Init_vim_dirvish()
    augroup dirvish_setup 
        autocmd!
        autocmd FileType dirvish call s:setup_dirvish()
    augroup END
endfunction
