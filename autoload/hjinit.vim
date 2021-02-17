" vim init
" init the basic param of vim

let g:hjvim_config={}
let g:log_level_flow = 2
let g:log_level_warning = 1
let g:log_level_error = 0

function! hjinit#setpath(base_dir,name,default)
    " default = 0: 需要根据系统信息来设置文件名
    " default = 1: 直接使用文件名
    if !isdirectory(a:base_dir)
        silent! call mkdir(a:base_dir, 'p')
    endif
    let l:hjparams_dir_sep = g:hjvim_config.sys.dir_sep
    let l:hjparam_connector = g:hjvim_config.sys.connector
    let l:hjparms_editor = g:hjvim_config.sys.editor
    let l:hjparams_arch = g:hjvim_config.sys.arch
    if !a:default
        let l:tempname = l:hjparams_dir_sep
        let l:tempname = l:tempname . a:name . l:hjparam_connector
        let l:tempname = l:tempname . l:hjparms_editor . l:hjparam_connector
        let l:tempname = l:tempname . l:hjparams_arch
        let l:tempname = l:tempname  
    else
        let l:tempname = l:hjparams_dir_sep . a:name 
    endif
    return a:base_dir . l:tempname
endfunction

function! hjinit#sys_init() 
    if !exists('g:hjvim_config.sys')
        let g:hjvim_config.sys = {}
    endif
    let g:hjvim_config.sys.connector = '_'
    if hjenv#IsWindows()
        "let g:hjvim_config.sys.dir_sep='\\'
        let g:hjvim_config.sys.dir_sep='\'
        let l:hjparams_arch='win'
        if hjenv#IsWin32()
            let g:hjvim_config.sys.arch=l:hjparams_arch.'32'
        elseif hjenv#IsWin64()
            let g:hjvim_config.sys.arch=l:hjparams_arch.'64'
        endif
    elseif hjenv#IsMac()
        let g:hjvim_config.sys.dir_sep='/'
        let g:hjvim_config.sys.arch='mac'
    elseif hjenv#IsLinux()
        let g:hjvim_config.sys.dir_sep='/'
        let g:hjvim_config.sys.arch='linux'
    endif
    if hjenv#IsVim8()
        let g:hjvim_config.sys.editor='vim'.string(v:version)
    elseif hjenv#IsNvim()
        let g:hjvim_config.sys.editor='nvim'
    endif

    let g:hjvim_config.extname = {}
    let g:hjvim_config.extname.group = 'grp' 
    let g:hjvim_config.extname.feature = 'fte' 
    let g:hjvim_config.extname.plug = 'vim' 

    let g:hjvim_config.sys.module_name_list= [
        \ 'all',
        \ 'group',
        \ 'feature',
        \ 'plug',
        \ ] 

    let g:hjvim_config.sys.sep_help_string = '=> '
    let g:hjvim_config.sys.sep_help_len = 30
    let g:hjvim_config.sys.log_level = g:log_level_error

    " load default settings
    let g:hjvim_config.sys.themes = {}
    let g:hjvim_config.sys.themes.colorscheme = 'gruvbox'
    let g:hjvim_config.sys.themes.background = 'dark'
    let g:hjvim_config.sys.plug_load_order = []

    " 一些插件如果使用的话需要将其在vim启动之前初始化,不明原因
    let g:hjvim_config.sys.pre_plug_list = []
    let g:hjvim_config.sys.ignore_plug_list = []

    let g:hjvim_config.sys.shell = &shell
    let g:hjvim_config.sys.complete = 'coc'
    let g:hjvim_config.sys.file_browser = 'nerdtree'
    let g:hjvim_config.sys.tag_bar = 'tagbar'
    let g:hjvim_config.sys.syntax_hilight = 'vim_polyglot'
    let g:hjvim_config.sys.status_line = 'airline'
    let g:hjvim_config.sys.status_line_themes = 'auto'


    "let g:hjvim_config.sys.py_version = '37'
    if hjenv#IsWindows()
        let g:hjvim_config.sys.python2_ver = 'Python27'
        let g:hjvim_config.sys.python3_ver = 'Python37'
        if hjenv#IsWin64()
            let g:hjvim_config.sys.python_three_path =  $HOME . '\AppData\Local\Programs\Python\Python37\'
            let g:hjvim_config.sys.python_path =  $HOME . '\AppData\Local\Programs\Python\Python27\'
        else
            let g:hjvim_config.sys.python_three_path =  $HOME . '\AppData\Local\Programs\Python\Python37-32\'
            let g:hjvim_config.sys.python_path =  $HOME . '\AppData\Local\Programs\Python\Python27-32\'
        endif
    endif
    if !exists('g:hjvim_config.var')
        let g:hjvim_config.var = {}
    endif
    if !exists('g:hjvim_config.var.help_keymap')
        let g:hjvim_config.var.help_keymap= {}
    endif
endfunction

function! hjinit#path_init() 
    if !exists('g:hjvim_config.path')
        let g:hjvim_config.path = {}
    endif 
    let g:hjvim_config.path.plugdir             = hjinit#setpath($VIMFILES,'plugged',0)
    let g:hjvim_config.path.configdir           = hjinit#setpath($VIMFILES,'config',1)
    let g:hjvim_config.path.settings            = hjinit#setpath($VIMFILES,'settings',1)
    let g:hjvim_config.path.utils               = hjinit#setpath($VIMFILES,'utils',1)
    let g:hjvim_config.path.help_doc            = hjinit#setpath($VIMFILES,'help_doc',1)
    let g:hjvim_config.path.group_conf_dir      = g:hjvim_config.path.configdir
    let g:hjvim_config.path.feature_conf_dir    = g:hjvim_config.path.configdir
    let g:hjvim_config.path.plug_conf_dir       = hjinit#setpath(g:hjvim_config.path.configdir ,'plugs',1)
    let g:hjvim_config.path.submoduledir        = hjinit#setpath($VIMFILES,'submodules',1)
    let g:hjvim_config.path.lspdir              = hjinit#setpath(g:hjvim_config.path.submoduledir,'lsp',1)
    let g:hjvim_config.path.ycmlsp_dir          = hjinit#setpath(g:hjvim_config.path.lspdir,'lsp-examples',1)
    let g:hjvim_config.path.tools_path          = []

    call insert(g:hjvim_config.path.tools_path,g:hjvim_config.path.utils)

    if hjenv#IsWindows()
        let g:hjvim_config.path.external_tools_dir = hjinit#setpath($VIMFILES,'..',1)
        let g:hjvim_config.path.winutils = hjinit#setpath(g:hjvim_config.path.external_tools_dir,'winutils',1)
        let g:hjvim_config.path.winutilsbin = hjinit#setpath(g:hjvim_config.path.winutils,'bin',1)
        let g:hjvim_config.path.gtagsbin = hjinit#setpath(g:hjvim_config.path.winutils,'bin',1)
        let g:hjvim_config.path.cppcheck = hjinit#setpath(g:hjvim_config.path.winutils,'cppcheck',1)
        call insert(g:hjvim_config.path.tools_path,g:hjvim_config.path.winutilsbin)
        call insert(g:hjvim_config.path.tools_path,g:hjvim_config.path.gtagsbin)
        call insert(g:hjvim_config.path.tools_path,g:hjvim_config.path.cppcheck)
        call insert(g:hjvim_config.path.tools_path,g:hjvim_config.sys.python_three_path)
        call insert(g:hjvim_config.path.tools_path,g:hjvim_config.sys.python_three_path . 'Scrips')
    endif

endfunction

function! hjinit#get(type1,type2) 
    let l:ret = 'error'
    if !exists('g:hjvim_config.'. a:type1)
        echo 'g:hjvim_config.'. a:type1
        return l:ret
    endif
    if !exists('g:hjvim_config.'. a:type1 . '.' . a:type2)
        echo 'g:hjvim_config.'. a:type1 . '.' . a:type2
        return l:ret
    endif

    execute 'let l:ret = ' . 'g:hjvim_config.' . a:type1 . '.' . a:type2
    return l:ret

endfunction

function! hjinit#set(type1,type2,...) 
    if a:type1 == 'sys'
        if a:0 == 1
            if a:type2 == 'log_level'
                let g:hjvim_config.sys.log_level = a:1
            elseif a:type2 == 'plug_load_order'
                call add(g:hjvim_config.sys.plug_load_order,a:1)
            elseif a:type2 == 'pre_plug_list'
                call add(g:hjvim_config.sys.pre_plug_list,a:1)
            elseif a:type2 == 'ignore_plug_list'
                call add(g:hjvim_config.sys.ignore_plug_list,a:1)
            elseif a:type2 == 'shell'
                let g:hjvim_config.sys.shell = a:1
            elseif a:type2 == 'complete'
                let g:hjvim_config.sys.complete = a:1
            elseif a:type2 == 'file_browser'
                let g:hjvim_config.sys.file_browser = a:1
            elseif a:type2 == 'status_line'
                let g:hjvim_config.sys.status_line = a:1
            elseif a:type2 == 'status_line_themes'
                let g:hjvim_config.sys.status_line_themes = a:1
            elseif a:type2 == 'tag_bar'
                let g:hjvim_config.sys.tag_bar = a:1
            elseif a:type2 == 'syntax_hilight'
                let g:hjvim_config.sys.syntax_hilight = a:1
            endif 
        elseif a:0 == 2
            if  a:type2 == 'themes'
                if a:1 == 'colorscheme'
                    let g:hjvim_config.sys.themes.colorscheme = a:2
                elseif a:1 == 'background'
                    let g:hjvim_config.sys.themes.background = a:2
                else
                    let g:hjvim_config.sys.themes.colorscheme = a:1
                    let g:hjvim_config.sys.themes.background = a:2
                endif
            endif
        endif
    endif
endfunction

function! hjinit#plug_init() 
    if !exists('g:hjvim_config.var.plugs')
        let g:hjvim_config.var.plugs = {} 
    endif
    call hjplug#init(hjinit#get('var','plugs'), hjinit#get('path','plug_conf_dir'),hjinit#get('extname','plug'))
endfunction

function! hjinit#feature_init() 
    if !exists('g:hjvim_config.var.features')
        let g:hjvim_config.var.features = {} 
    endif
    call hjfeature#init(hjinit#get('var','features'),hjinit#get('path','feature_conf_dir'),hjinit#get('extname','feature'))
endfunction

function! hjinit#group_init() 
    if !exists('g:hjvim_config.var.groups')
        let g:hjvim_config.var.groups = {} 
    endif
    call hjgroup#init(hjinit#get('var','groups'),hjinit#get('path','group_conf_dir'),hjinit#get('extname','group'))
endfunction

function! hjinit#setdefault() 
    call hjinit#sys_init()
    call hjinit#path_init()
endfunction

function! hjinit#init(cb)
    call hjinit#setdefault() 
    call a:cb()

    call hjinit#plug_init()
    call hjinit#feature_init()
    call hjinit#group_init()

    call hjplug#preload_by_vimplug(hjinit#get('path','plugdir'),hjinit#get('var','plugs'))
    call hjgroup#run_group(g:hjvim_config.var.groups.generic)
    call hjutils#full_screen()
endfunction

