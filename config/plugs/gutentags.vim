" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时01分09秒
" File Name: config/plug_conf/gutentags.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
\ 'cmdline' :   [
\               ['ludovicchabant/vim-gutentags'],
\               ['skywind3000/gutentags_plus'],
\               ['skywind3000/vim-preview'],
\               ],
\ 'mode'    :   'normal',
\ 'func'    :   ['Init_gutentags'],
\ 'hotkeys' :   {
\   '<leader>cs':   {
\                    'cmdstart'  :'noremap <silent>',
\                    'cmdend'    :':GscopeFind s <C-R><C-W><cr>',
\                    'desc'      :'Find this symbol',
\                   },
\   '<leader>cg':   {
\                    'cmdstart'  :'noremap <silent>',
\                    'cmdend'    :':GscopeFind g <C-R><C-W><cr>',
\                    'desc'      :'Find this definition',
\                   },
\   '<leader>cc':   {
\                    'cmdstart'  :'noremap <silent> ',
\                    'cmdend'    :':GscopeFind c <C-R><C-W><cr>',
\                    'desc'      :'Find functions calling this function',
\                   },
\   '<leader>ct':   {
\                    'cmdstart'  :'noremap <silent>',
\                    'cmdend'    :':GscopeFind t <C-R><C-W><cr>',
\                    'desc'      :'Find this text string',
\                   },
\   '<leader>ce':   {
\                    'cmdstart'  :'noremap <silent>',
\                    'cmdend'    :':GscopeFind e <C-R><C-W><cr>',
\                    'desc'      :'Find this egrep pattern',
\                   },
\   '<leader>cf':   {
\                    'cmdstart'  :'noremap <silent>',
\                    'cmdend'    :':GscopeFind f <C-R>=expand("<cfile>")<cr><cr>',
\                    'desc'      :'Find this file',
\                   },
\   '<leader>ci':   {
\                    'cmdstart'  :'noremap <silent>',
\                    'cmdend'    :':GscopeFind i <C-R>=expand("<cfile>")<cr><cr>',
\                    'desc'      :'Find files #including this file',
\                   },
\   '<leader>cd':   {
\                    'cmdstart'  :'noremap <silent>',
\                    'cmdend'    :':GscopeFind d <C-R><C-W><cr>',
\                    'desc'      :'Find functions called by this function',
\                   },
\   '<leader>ca':   {
\                    'cmdstart'  :'noremap <silent>',
\                    'cmdend'    :':GscopeFind a <C-R><C-W><cr>',
\                    'desc'      :'Find places where this symbol is assigned a value',
\                   },
\   'p':            {
\                    'cmdstart'  :'autocmd FileType qf nnoremap <silent><buffer>',
\                    'cmdend'    :':PreviewQuickfix<cr>',
\                    'desc'      :'打开预览窗口',
\                   },
\   'P':            {
\                    'cmdstart'  :'autocmd FileType qf nnoremap <silent><buffer>',
\                    'cmdend'    :':PreviewClose<cr>',
\                    'desc'      :'关闭预览窗口',
\                   },
\   '<leader>u':    {
\                    'cmdstart'  :'noremap ',
\                    'cmdend'    :':PreviewScroll -1<cr>',
\                    'desc'      :'预览窗口向上翻页',
\                   },
\   '<leader>d':    {
\                    'cmdstart'  :'noremap ',
\                    'cmdend'    :':PreviewScroll +1<cr>',
\                    'desc'      :'预览窗口向下翻页',
\                   },
\   },
\}

function! Pluginfo_gutentags()
    return s:pluginfo 
endfunction

function! Init_gutentags()
    call Gutentags_init()
endfunction

function! Gutentags_init() 
    " 打开gutentags的debug和trace模式 
    let g:gutentags_define_advanced_commands = 1
    let g:gutentags_trace = 1
endfunction

function! s:ctags_default() 
    "设置默认的ctags参数,详见 man ctags
    "或https://github.com/universal-ctags/ctags/blob/master/docs/man/ctags.1.rst
    let g:gutentags_ctags_extra_args = []

    " 定义ctag文件的输出格式为Exuberant-ctags 
    " 详情见man 5 tags, 此文档内说使用默认的u-ctags会有异常,所以使用e-ctags
    let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

    " 设置fields
    " fields指定tags的可用扩展域(extension fields)
    " 例如'+n'代表给tag文件中的每一项加入行号
    " 可以通过ctags --list-fields参数查看默认的设置
    " 也可以查看某语言的值,比如c语言的设置:ctags --list-fields=c
    let g:gutentags_ctags_extra_args += ['--fields=+iaS']

    " 设置extra
    let g:gutentags_ctags_extra_args += ['--extras=+q']

    " 针对c语言
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']

endfunction

function! Pre_gutentags_init() 
    " vim-gutentags中有一些代码会在source的时候直接进行初始化
    " 由此导致这里很多设置无法实现
    " 所以一些配置在source这个脚本的时候直接实则hi
    
    let $GTAGSLABEL = 'native-pygments'
    if exists('g:hjvim_config.path.plugdir')
        let l:tempdir = g:hjvim_config.path.plugdir
    else
        let l:tempdir = $VIMFILES
    endif

    if hjenv#IsWindows()
        " save the tags files into vimfiles
        let l:winutils = hjinit#get('path','winutils')
        let $GTAGSCONF = l:winutils . '\share\gtags\gtags.conf'
    else
        " save the tags files into  ~/.cache/tags
        let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
    endif

    "gtags并不主动识别.h 中的C++类，除非设置GTAGSFORCECPP 环境变量。
    let $GTAGSFORCECPP=1
        
    " 将所有生成的tags文件放到一个位置,会和.gutctags的配置冲突
    let s:vim_tags = expand(l:tempdir . '/cache/tags')
    let g:gutentags_cache_dir = s:vim_tags
    if !isdirectory(s:vim_tags) " auto create tags folder
        silent! call mkdir(s:vim_tags, 'p')
    endif

    set tags=./.tags;,.tags
    let g:gutentags_project_root = ['.root', '.git', '.svn', 'hg']
    " 设置那些文件不使用gutentags
    let g:gutentags_exclude_filetypes = ['vim','rst','txt','text','markdown','md','tex','sh','dts','log','tag'] 
    let g:gutentags_ctags_tagfile = '.tags'
    " check gtags and ctags, if support both , add them all
    
    " 设置生成的tag的种类
    let g:gutentags_modules = []
    if executable('ctags') " 生成ctags类型文件, 这里使用Universal Ctags.
        let g:gutentags_modules += ['ctags']
        call s:ctags_default() 
    endif
    if executable('gtags-cscope') && executable('gtags')
        " 生成GNU tags database
        let g:gutentags_modules += ['gtags_cscope']
    endif


    " for test
    " let g:gutentags_ctags_extra_args += ['--exclude="drivers"']
    " 不自动加载gtags数据库文件

    " 设置gtags操作的文件列表
    " gtags配置文件列表有两种办法
    " 1. 使用下面的方式,通过gutentags_file_list_command设置 
    "let g:gutentags_file_list_command = 'find ./src/test/lccode -type f -name *.c -o -type f -name *.h'
    " 2. 使用gutctags文件
    " 没搞懂
    "
    
    let g:gutentags_auto_add_gtags_cscope = 0

    " tagfile的更新设置,可以通过命令GutentagsUpdate 手动更新tagfile
    " 在写文件后不自动更新tags, 否则代码量大的时候会很慢
    let g:gutentags_generate_on_write = 0
    
    "在打开的文件没有被生成tagsfile的时候自动生成
    "let g:gutentags_generate_on_missing = 0
    " 工程中加入新的文件后更新tag    
    "let g:gutentags_generate_on_new = 0

    " 不使用默认热键
    let g:gutentags_plus_nomap = 1


endfunction


