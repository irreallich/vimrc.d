" VIM scripts
" Author: hjwang
" Created Time : 2019年10月15日 星期二 10时09分19秒
" File Name: config/plug/generic.vim
" Description:
"""

" 保存一些不使用的键值定义
"            \               'jj':           {
"            \                               'cmdstart'  :'inoremap ',
"            \                               'cmdend'    :'',
"            \                               'desc'      :'insert模式下替代ESC',
"            \                               },
"    \               '<leader>t':    {
"    \                               'cmdstart'  :'noremap <silent>',
"    \                               'cmdend'    :':tabnew<cr>',
"    \                               'desc'      :'在最后tab后面打开一个新的tab',
"    \                               },




let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
    \ 'cmdline' : [
    \             ],
    \ 'mode'    : 'pre',
    \ 'func'    : ['Init_generic'],
    \ 'hotkeys' :   {
    \               '<leader>hh':   {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':Hjhelp<cr>',
    \                               'desc'      :'显示此帮助',
    \                               },
    \               '<c-h>':        [
    \                                   {
    \                                   'cmdstart'  :'noremap <unique> ',
    \                                   'cmdend'    :'<c-w>h',
    \                                   'desc'      :'跳转到左侧窗口',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'inoremap <unique> ',
    \                                   'cmdend'    :'<esc><c-w>h',
    \                                   'desc'      :'跳转到左侧窗口',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'tnoremap <unique> ',
    \                                   'cmdend'    :'<c-n><c-w>h',
    \                                   'desc'      :'跳转到左侧窗口',
    \                                   },
    \                               ],
    \               '<c-j>':        [
    \                                   {
    \                                   'cmdstart'  :'noremap <unique> ',
    \                                   'cmdend'    :'<c-w>j',
    \                                   'desc'      :'跳转到下侧窗口',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'inoremap <unique> ',
    \                                   'cmdend'    :'<esc><c-w>j',
    \                                   'desc'      :'跳转到下侧窗口',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'tnoremap <unique> ',
    \                                   'cmdend'    :'<c-n><c-w>j',
    \                                   'desc'      :'跳转到下窗口',
    \                                   },
    \                               ],
    \               '<c-k>':        [
    \                                   {
    \                                   'cmdstart'  :'noremap <unique> ',
    \                                   'cmdend'    :'<c-w>k',
    \                                   'desc'      :'跳转到上侧窗口',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'inoremap <unique> ',
    \                                   'cmdend'    :'<esc><c-w>k',
    \                                   'desc'      :'跳转到上侧窗口',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'tnoremap <unique> ',
    \                                   'cmdend'    :'<c-n><c-w>k',
    \                                   'desc'      :'跳转到上侧窗口',
    \                                   },
    \                               ],
    \               '<c-l>':        [
    \                                   {
    \                                   'cmdstart'  :'noremap <unique> ',
    \                                   'cmdend'    :'<c-w>l',
    \                                   'desc'      :'跳转到右侧窗口',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'inoremap <unique> ',
    \                                   'cmdend'    :'<esc><c-w>l',
    \                                   'desc'      :'跳转到右侧窗口',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'tnoremap <unique> ',
    \                                   'cmdend'    :'<c-n><c-w>l',
    \                                   'desc'      :'跳转到右侧窗口',
    \                                   },
    \                               ],
    \               '<leader>co':   {
    \                               'cmdstart'  :'noremap <silent> <unique> ',
    \                               'cmdend'    :':copen<cr>',
    \                               'desc'      :'显示quickfix结果窗口',
    \                               },
    \               '<leader>cb':   {
    \                               'cmdstart'  :'noremap <silent> <unique> ',
    \                               'cmdend'    :':cprev<cr>',
    \                               'desc'      :'显示quickfix前一个结果',
    \                               },
    \               '<leader>cn':   {
    \                               'cmdstart'  :'noremap <silent> <unique> ',
    \                               'cmdend'    :':cnext<cr>',
    \                               'desc'      :'显示quickfix后一个结果',
    \                               },
    \               '<leader>1':    {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':tabn 1<cr>',
    \                               'desc'      :'打开此编号的tab',
    \                               },
    \               '<leader>2':    {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':tabn 2<cr>',
    \                               'desc'      :'打开此编号的tab',
    \                               },
    \               '<leader>3':    {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':tabn 3<cr>',
    \                               'desc'      :'打开此编号的tab',
    \                               },
    \               '<leader>4':    {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':tabn 4<cr>',
    \                               'desc'      :'打开此编号的tab',
    \                               },
    \               '<leader>5':    {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':tabn 5<cr>',
    \                               'desc'      :'打开此编号的tab',
    \                               },
    \               '<leader>6':    {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':tabn 6<cr>',
    \                               'desc'      :'打开此编号的tab',
    \                               },
    \               '<leader>7':    {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':tabn 7<cr>',
    \                               'desc'      :'打开此编号的tab',
    \                               },
    \               '<leader>8':    {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':tabn 8<cr>',
    \                               'desc'      :'打开此编号的tab',
    \                               },
    \               '<leader>9':    {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':tabn 9<cr>',
    \                               'desc'      :'打开此编号的tab',
    \                               },
    \               '<tab>h':       [
    \                                   {
    \                                   'cmdstart'  :'noremap <unique> ',
    \                                   'cmdend'    :'gT',
    \                                   'desc'      :'移动到上一个tab',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'inoremap <unique> ',
    \                                   'cmdend'    :'<esc>gT',
    \                                   'desc'      :'移动到上一个tab',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'tnoremap <unique> ',
    \                                   'cmdend'    :'<c-n><c-w>gT',
    \                                   'desc'      :'移动到上一个tab',
    \                                   },
    \                               ],
    \               '<tab>l':       [
    \                                   {
    \                                   'cmdstart'  :'noremap <unique> ',
    \                                   'cmdend'    :'gt',
    \                                   'desc'      :'移动到下一个tab',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'inoremap <unique> ',
    \                                   'cmdend'    :'<esc>gt',
    \                                   'desc'      :'移动到下一个tab',
    \                                   },
    \                                   {
    \                                   'cmdstart'  :'tnoremap <unique> ',
    \                                   'cmdend'    :'<c-n><c-w>gt',
    \                                   'desc'      :'移动到下一个tab',
    \                                   },
    \                               ],
    \               '<tab>b':       {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':bp<cr>',
    \                               'desc'      :'移动到上一个buffer',
    \                               },
    \               '<tab>n':       {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':bn<cr>',
    \                               'desc'      :'移动到下一个buffer',
    \                               },
    \               'U':            {
    \                               'cmdstart'  :'nnoremap <silent>',
    \                               'cmdend'    :'<nop>',
    \                               'desc'      :'关闭默认的U按键功能',
    \                               },
    \               'Q':            {
    \                               'cmdstart'  :'map',
    \                               'cmdend'    :'gq',
    \                               'desc'      :'不使用ex模式 修改Q键功能',
    \                               },
    \               '<leader><leader><leader>':  
    \                               {
    \                               'cmdstart'  :'nnoremap',
    \                               'cmdend'    :':nohl <cr>',
    \                               'desc'      :'清除搜索高亮光标',
    \                               },
    \               '<leader>ht':   {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':terminal++curwin<cr>',
    \                               'desc'      :'在当前窗口打开默认终端',
    \                               },
    \               '<leader>hb':   {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':terminal++curwin bash<cr>',
    \                               'desc'      :'在当前窗口打开bash终端',
    \                               },
    \               '<leader>hc':   {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':terminal++curwin cmd<cr>',
    \                               'desc'      :'Windows下打开cmd终端,其他系统清忽略',
    \                               },
    \               '<leader>pb':   {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':call hjutils#add_breakpoint("ipdb")<cr>',
    \                               'desc'      :'python加入断点',
    \                               },
    \               't':            {
    \                               'cmdstart'  :'noremap <silent>',
    \                               'cmdend'    :':call hjutils#open_qf_file(":tabedit +")<cr>',
    \                               'desc'      :'11111',
    \                               },
    \               '[[':           {'desc'     :'Jump to previous class or function (normal, visual, operator modes)'},
    \               ']]':           {'desc'     :'Jump to next class or function  (normal, visual, operator modes)'},
    \               '[M':           {'desc'     :'Jump to previous class or method (normal, visual, operator modes)'},
    \               ']M':           {'desc'     :'Jump to next class or method (normal, visual, operator modes)'},
    \               'aC':           {'desc'     :'Select a class. Ex: vaC, daC, yaC, caC (normal, operator modes)'},
    \               'iC':           {'desc'     :'Select a class. Ex: vaC, daC, yaC, caC (normal, operator modes)'},
    \               'aM':           {'desc'     :'Select a function or method. Ex: vaM, daM, yaM, caM (normal, operator modes)'},
    \               'iM':           {'desc'     :'Select inner function or method. Ex: viM, diM, yiM, ciM (normal, operator modes)'},
    \               },
    \}



function! Pluginfo_generic()
    return s:pluginfo 
endfunction

function! Init_generic() 
    call Generic_basic_init()
    call Generic_swap_init()
    call Generic_optional_init()
    call Generic_filetype_init()
    call Generic_python_init() 
    call Generic_os_init()
    call Generic_editor_init()
    call Generic_kmap_init()
    call Generic_terminal_init()
endfunction

function! Generic_basic_init() 
    " 一般功能设置
    set wrap                            " 打开自动换行
    set backspace   =indent,eol,start   " 允许在自动缩进，换行符以及插入的位置使用backspace 
    set ttimeout                        " 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
    set ttimeoutlen=50                  " 功能键超时检测 50 毫秒

    " 设置搜索
    set ignorecase                      " 搜索的时候忽略大小写
    set smartcase                       " 如果搜索内容有大写字符则忽略ignorecase
    set hlsearch                        " 高亮搜索结果
    set incsearch                       " 搜索时部分匹配就高亮显示

    " 允许 Vim 自带脚本根据文件类型自动设置缩进等
    if has('autocmd')
        filetype plugin indent on
    endif

    if has('syntax')
        syntax enable 
        syntax on                       " 打开语法高亮
        "set colorcolumn =81,101        " 加一行列的竖线
    endif

    set showmatch                       " 插入括号时，短暂地跳转到匹配的对应括号。
    set matchtime=2                     " 显示括号匹配的时间

    set history=300                     " 保存历史记录数
    set display=lastline                " 显示最后一行
    " set lazyredraw                      " 延迟绘制（提升性能）,慎重打开

    set shortmess=atI                   " 去掉欢迎界面 
    set laststatus  =2                  " 总是显示statusline.
    set cursorline                      " 高亮当前行
    set number                          " 显示行数
    set autoread                        " 自动载入修改过的文件
    set cmdheight    =2                 " 命令行占用两行
    set hidden                          " 允许在不保存的情况下切换缓冲区
    set report      =0                  " Always report changed lines.
    set whichwrap+=<,>,h,l              " 设置插入退格以及移动等可以换行

    set scrolloff=6                     " 设置光标在屏幕顶端或者低端需要保留的行数
    set belloff=all                     " 关掉提示音
    " 语法高亮支持的最大长度 ,此值如果设置太短，可能会导致包含特别长代码的文件的语法高亮出错
    set synmaxcol=0                  
    " 设置coding style,tab转换为4个space
    set expandtab                       " 默认使用space替换tab
    set tabstop=4                       " tab所代表的列数
    set shiftwidth=4                    " 缩进的列数
    set softtabstop=4                   " tab转换为4个空格 
    set smarttab                        " 打开smarttab
    set shiftround                      " 缩进取整到 'shiftwidth' 的倍数
    "  设置session记录的内容
    set sessionoptions+=slash
    set sessionoptions+=unix
    if hjenv#IsGui()
        set sessionoptions+=resize
    endif
    set sessionoptions-=options
    set sessionoptions-=winsize
    set sessionoptions-=folds
    " 使用小光标
    " set gcr=n-v-c:ver25-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor

    set updatetime=1000                 " 测试时default的值是4000，有问题的话将其删掉
    set noswapfile                      " 不使用交换文件

    " set signcolumn=yes                  " 显示侧边栏 
    set splitright                      " 水平切割窗口时，默认在右边显示新窗口

    " 设置按照语法隐藏一部分关键字功能,主要对markdown有用
    "set conceallevel=0
    "set concealcursor=


    " 缩进 不设置自动缩进,不习惯
    " set autoindent
    " set cindent

endfunction

function! Generic_optional_init() 
    if has('wildmenu')                  " 设置命令行补全功能
        set wildmenu
        set wildmode=longest,full
        set wildignore=*.swp,*.bak
        set wildignore+=*.min.*,*.css.map
        set wildignore+=*.jpg,*.png,*.gif
        set wildignorecase
    endif

    set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m  " 设置错误格式
    set tags=./.tags;,.tags                      " 设置默认tags的参数

    " 显示各种分隔符
    set list    " 设置显示制表符等隐藏字符
    let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'

    set formatoptions+=m                " 如遇Unicode值大于255的文本，不必等到空格再折行
    set formatoptions+=M                " 合并两行中文时，不在中间加空格

    " 代码折叠
    if has('folding')
        set foldenable          " 允许代码折叠
        set foldmethod=indent          " 代码折叠默认使用缩进
        set foldlevel=99        " 默认打开所有缩进
    endif


    " 文件搜索和补全时忽略下面扩展名
    set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

    set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib 
    set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
    set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
    set wildignore+=*DS_Store*,*.ipch
    set wildignore+=*.gem
    set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
    set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.dmg,*/.rbenv/**
    set wildignore+=*/.nx/**,*.app,*.git,.git
    set wildignore+=*.wav,*.mp3,*.ogg,*.pcm,*.ape,*.wav
    set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
    set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
    set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
    set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
    set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
    set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
    set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android

    " 下面的代码用来自动将多余的空格和tab显示成红色，并在退出的时候将其删掉
    " see [http://vim.wikia.com/wiki/highlight_unwanted_spaces]
    " - highlight trailing whitespace in red
    " - have this highlighting not appear whilst you are typing in insert mode
    " - have the highlighting of whitespace apply when you open new buffers
    "highlight extrawhitespace ctermbg=red guibg=red
    "match extrawhitespace /\s\+$/
    "autocmd bufwinenter * match extrawhitespace /\s\+$/
    "autocmd insertenter * match extrawhitespace /\s\+\%#\@<!$/
    "autocmd insertleave * match extrawhitespace /\s\+$/
    "autocmd bufwinleave * call clearmatches() 

endfunction

function! Generic_swap_init() 
    let g:hjparam_backup = 0
    let g:hjparam_undofile = 0
    if exists('g:hjvim_config.path.plugdir')
        let l:tempdir = g:hjvim_config.path.plugdir
    else
        let l:tempdir = $VIMFILES
    endif
    " Put all temporary files under the same directory.
    if !isdirectory(l:tempdir . '/files') " auto create tags folder
        silent! call mkdir(l:tempdir . '/files', 'p')
    endif
    if !isdirectory(l:tempdir . '/files/backup') " auto create tags folder
        silent! call mkdir(l:tempdir . '/files/backup', 'p')
    endif
    if !isdirectory(l:tempdir . '/files/swap') " auto create tags folder
        silent! call mkdir(l:tempdir . '/files/swap', 'p')
    endif
    if !isdirectory(l:tempdir . '/files/undo') " auto create tags folder
        silent! call mkdir(l:tempdir . '/files/undo', 'p')
    endif
    if !isdirectory(l:tempdir . '/files/info') " auto create tags folder
        silent! call mkdir(l:tempdir . '/files/info', 'p')
    endif

    if g:hjparam_backup
        set backup
        let &backupdir   =l:tempdir . '/files/backup/'
        set backupext   =-vimbackup
        set backupskip  =
    else
        set nobackup                        " without backup
        set nowritebackup                   " without backup
    endif
    let &directory   =l:tempdir . '/files/swap/'
    set updatecount =10
    if g:hjparam_undofile
        set undofile
        let &undodir     =l:tempdir . '/files/undo/'
    endif
    if hjenv#IsVim8()
        let &viminfo     ='''500,f1,<50,n' . l:tempdir . '/files/info/viminfo'
    elseif hjenv#IsNvim() 
        let &viminfo     ='''500,f1,<50,n' . l:tempdir . '/files/info/viminfo'
    endif
endfunction
function! Generic_filetype_init() 
    "
    " 设置语言和encodeing 
    set encoding=utf-8              " 内部工作编码
    set fileencoding=utf-8          " 文件默认编码
    set termencoding=utf-8
    set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1

    set fileformat=unix
    "set fileformats=unix,dos,mac    " 文件换行符，默认使用 unix 换行符
    if v:lang=~? '^\(zh\)\|\(ja\)\|\(ko\)'
        if hjenv#IsNvim()  

        else
            set ambiwidth=double                " 使用双倍宽度的字符
        endif
    endif
    " 设置行显示长度
    set linebreak
    set breakindent
endfunction

function! Generic_python_init() 
    if hjenv#IsWindows()
        if hjenv#IsVim8()
            let &pythonthreedll = g:hjvim_config.sys.python_three_path . g:hjvim_config.sys.python3_ver . '.dll' 
            let &pythondll = g:hjvim_config.sys.python_path .  g:hjvim_config.sys.python2_ver . '.dll'
            if !filereadable(&pythondll)
                set pythondll&
            endif
            if !filereadable(&pythonthreedll)
                set pythonthreedll&
            endif
            " set pyx  , first priority is python3
            if has('python3')
                set pyx=3
            elseif has('python')
                set pyx=2
            endif
        elseif hjenv#IsNvim()
            let g:nvim_config_path = stdpath('config')
            if !filereadable(g:nvim_config_path.'/init.vim')
                if !isdirectory(g:nvim_config_path)
                    silent! call mkdir(g:nvim_config_path , 'p')
                endif
                exec '!echo source ' . $VIMFILES . '\vimrc > ' . g:nvim_config_path . '\init.vim'
            endif
        endif
        let g:python_host_prog = g:hjvim_config.sys.python_path  . 'python.exe'
        let g:python3_host_prog = g:hjvim_config.sys.python_three_path  . 'python.exe'
    else
    endif

endfunction

function! Generic_os_init() 
    if hjenv#IsWindows()
        call Generic_win_init()
        let l:tt = ';'
    elseif hjenv#IsUnix()
        call Generic_unix_init()
        let l:tt = ':'
    endif
    "set external tools
    for l:path in hjinit#get('path','tools_path')
        let $PATH = l:path .l:tt . $PATH
    endfor
endfunction

function! Generic_win_init() 
    if hjenv#IsWin32()
        call Generic_win32_init()
    elseif hjenv#IsWin64()
        call Generic_win64_init()
    endif  

    if has('mouse')                     " always try to use mouse
        set mouse=a
    endif

    " win下alt键使用,我不习惯alt键使用,不打开此功能
    " set winaltkeys=no  "Windows禁用ALT操作菜单(使得 ALT 可以用到 Vim里)

    execute 'set shell='.hjinit#get('sys','shell')

endfunction

function! Generic_win32_init() 
endfunction

function! Generic_win64_init() 
endfunction

function! Generic_editor_init() 
    if hjenv#IsVim8()
        call Generic_vim8_init()
    elseif hjenv#IsNvim()
        call Generic_Nvim_init()
    endif
endfunction
function! Generic_unix_init() 
    " 如果外层有tmux,那么vim是本地通信，使用短 ttimeoutlen
    if $TMUX != ''
        " 使用tmux
        set ttimeoutlen=20

        " 防止tmux下vim的背景色显示异常
        " Refer: http://sunaku.github.io/vim-256color-bce.html
        if &term =~? '256color' 
        " disable Background Color Erase (BCE) so that color schemes
        " render properly when inside 256-color tmux and GNU screen.
        " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
            set t_ut=
        endif
    elseif &ttimeoutlen > 60 || &ttimeoutlen <= 0
        set ttimeoutlen=60
    endif

endfunction

function! Generic_vim8_init() 
    " set windows
    if hjenv#IsGui()
        set guioptions-=m           " disable menu
        set guioptions-=T           " disable toolsbar
        set guioptions-=r
        set guioptions-=L
        set guifont=Monaco_for_Powerline:h11:w6:cANSI:qDRAFT
        "set guifont=更纱黑体_Mono_SC_Nerd:h14:W300:cANSI:qDRAFT
    else
        if has('termguicolors')
            set termguicolors
        else
            set t_Co=256
        endif
    endif
endfunction
function! Generic_Nvim_init() 
    " neovim图形界面的配置在~/.config/nvim/ginit.vim中
endfunction

function! Generic_kmap_init() 
    cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
    " disable some default hotkeys
    nnoremap U <nop> 
endfunction

function! Generic_terminal_init()
    " 给vim terminal的drop功能使用,从skywind3000/vim-terminal-help获得
    let $VIM_SERVERNAME = v:servername
    let $VIM_EXE = v:progpath
endfunction


