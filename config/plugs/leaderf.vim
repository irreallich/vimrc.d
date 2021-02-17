" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时46分03秒
" File Name: config/plug_conf/leaderf.vim
" Description:
"""

" rainbow need auto load, otherwise it couldn't work fine
let s:pluginfo =    {
\'cmdline' :        [
\                   ['Yggdroot/LeaderF'],
\                   ],
\'mode'    :        'normal',
\'func'    :        ['Init_leaderf'],
\'hotkeys' :        {
\   '<leader>ls':   {
\                   'cmdstart'  :'noremap <unique> ',
\                   'cmdend'    :':<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>',
\                   'desc'      :'在工程中搜索光标所在字符串',
\                   },
\   '<leader>las':  {
\                   'cmdstart'  :'noremap <unique> ',
\                   'cmdend'    :':<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR>',
\                   'desc'      :'追加搜索',
\                   },
\   '<leader>lbs':  {
\                   'cmdstart'  :'noremap <unique> ',
\                   'cmdend'    :':<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>',
\                   'desc'      :'在当前buffer中搜索',
\                   },
\   '<leader>lvs':  {
\                   'cmdstart'  :'xnoremap <unique> ',
\                   'cmdend'    :':<C-U><C-R>=printf("Leaderf! rg -F --stayOpen -e %s ", leaderf#Rg#visual())<CR>',
\                   'desc'      :'搜索选定文本',
\                   },
\   '<leader>lo':   {
\                   'cmdstart'  :'noremap <unique> ',
\                   'cmdend'    :':<C-U>Leaderf! rg --stayOpen --recall<CR>',
\                   'desc'      :'打开搜索的结果或者重做上次的搜索',
\                   },
\   '<leader>lf':   {
\                   'cmdstart'  :'let g:Lf_ShortcutF = "',
\                   'cmdend'    :'"',
\                   'desc'      :'打开工程内的文件',
\                   },
\   '<leader>lbf':  {
\                   'cmdstart'  :'let g:Lf_ShortcutB = "',
\                   'cmdend'    :'"',
\                   'desc'      :'打开buffer列表',
\                   },
\   '<leader>lm':   {
\                   'cmdstart'  :'noremap <unique> ',
\                   'cmdend'    :':LeaderfFunction!<cr>',
\                   'desc'      :'打开函数列表',
\                   },
\   '<leader>lat':  {
\                   'cmdstart'  :'noremap',
\                   'cmdend'    :':LeaderfTag<cr>',
\                   'desc'      :'打开全部tag列表',
\                   },
\   '<leader>lt':   {
\                   'cmdstart'  :'noremap',
\                   'cmdend'    :':LeaderfBufTag<cr>',
\                   'desc'      :'打开当前文件tag列表',
\                   },
\   },
\}

function! Pluginfo_leaderf()
    return s:pluginfo 
endfunction

function! Init_leaderf()
    "Specify the files and directories you want to exclude while indexing.
    let g:Lf_WildIgnore = {
    \ 'dir': ['.svn','.git','__pycache__','env','build','tools','submodules'],
    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[cod]','*.ico','*.bmp','*.BMP','*.png','*.PNG','*.JPG','*.jpg','*.ini','*.xml']
    \}
    let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']

    let g:Lf_StlColorscheme = 'gruvbox_material'

    let g:Lf_RootMarkers = ['.root','.git','.svn','.project','.gitignore']
    let g:Lf_StlSeparator = { 'left':' ', 'right':' ', }
    let g:Lf_WorkingDirectoryMode = 'Ac'
    if exists('g:hjvim_config.path.plugdir')
        let l:tempdir = g:hjvim_config.path.plugdir
    else
        let l:tempdir = $VIMFILES
    endif

    if hjenv#IsWindows()
        let g:Lf_CacheDirectory = expand(l:tempdir . '\cache')
    else
        let g:Lf_CacheDirectory = expand(l:tempdir . '/cache')
    endif
    
    " 默认禁用 function/buftag 的全部自动预览功能，可以手动用 p 预览
    " 在后面可以配置想用的预览设置
    let g:Lf_PreviewResult = {
            \ 'File': 0,
            \ 'Buffer': 0,
            \ 'Mru': 0,
            \ 'Tag': 0,
            \ 'BufTag': 0,
            \ 'Function': 0,
            \ 'Line': 0,
            \ 'Colorscheme': 0,
            \ 'Rg': 0,
            \ 'Gtags': 0
            \}



    if hjenv#IsNvim()
        let l:winpos = 'right'
    else 
        let l:winpos = 'popup'
    endif

    let g:Lf_WindowPosition = l:winpos
    if g:Lf_WindowPosition ==# 'bottom'
        let g:Lf_WindowHeight = 0.20
    elseif g:Lf_WindowPosition ==# 'popup'
        let g:Lf_PopupPosition = [2 , 0] " popup 窗口位置屏幕中间偏上
        " popup窗口显示在屏幕上右方,但是在gui模式下获得的&columns值偏小
        "let g:Lf_PopupPosition = [2 , &columns - float2nr(&columns*0.5)]  
        "let g:Lf_PopupHeight = float2nr(&lines*0.3) " 窗口高度 0.5
        "let g:Lf_PopupWidth = float2nr(&columns*0.5) 
        let g:Lf_PreviewInPopup = 1 " 是否在popup中preview
        let g:Lf_PopupPreviewPosition = 'bottom'
        " 打开相应预览功能

    elseif g:Lf_WindowPosition ==# 'right' 
        let g:Lf_PreviewHorizontalPosition = 'left'
    endif

    if g:Lf_PreviewInPopup == 1 " 如果在popup中进行preview
        let g:Lf_PopupColorscheme = 'gruvbox_default' "设置popup window的皮肤
        let g:Lf_PreviewResult['Rg'] = 0 "打开搜索相应的预览,关闭,因为搜索到特别长的行会死掉
        let g:Lf_PreviewResult['BufTag'] = 1 "打开当前文件tag的预览
        let g:Lf_PreviewResult['Function'] = 1 "打开当前函数预览
    endif


    let g:Lf_CtagsFuncOpts = {
    \ 'c': '--c-kinds=fp',
    \ 'c++': '--c++-kinds=fp',
    \ 'python': '--python-kinds=fp',
    \ 'rust': '--rust-kinds=f',
    \}
    let g:Lf_ShowRelativePath = 1

    " 使用 ESC 键可以直接退出 leaderf 的 normal 模式
    let g:Lf_NormalMap = {
    \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
    \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
    \ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
    \ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
    \ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
    \ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
    \ }

    " 替换leaderf 插件中默认的键
    let g:Lf_CommandMap = {
    \   '<C-R>': ['<C-E>'],
    \   '<C-F>': ['<C-D>'],
    \   '<C-Up>': ['<C-K>'],
    \   '<C-Down>': ['<C-J>'],
    \ }

    "打开对nerd font显示图标的支持,需要相应字体支持
    if hjenv#IsWindows()
        let g:Lf_ShowDevIcons = 0 
    else
        let g:Lf_ShowDevIcons = 0 
    endif

    " the following setting may make problems about display
    "let g:Lf_Gtagsconf = '/usr/local/share/gtags/gtags.conf'
    "let g:Lf_Gtagslabel = 'native-pygments'
    "let g:Lf_GtagsAutoGenerate = 1
      " this line is used to change the default hotkeys

endfunction

