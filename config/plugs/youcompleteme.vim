" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 15时16分24秒
" File Name: config/plug_conf/youcompleteme.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['Valloric/YouCompleteMe'],
                        \ ['Shougo/echodoc.vim'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_youcompleteme'],
            \ 'hotkeys' : {
            \               '<leader>yj':   {
            \                               'cmdstart'  :'noremap <silent>',
            \                               'cmdend'    :':rightbelow vertical YcmCompleter GoTo<CR>',
            \                               'desc'      :'右窗口中打开定义',
            \                               },
            \               '<leader>ytj':  {
            \                               'cmdstart'  :'noremap <silent>',
            \                               'cmdend'    :':tab YcmCompleter GoToDefinition<CR>',
            \                               'desc'      :'新标签中打开定义',
            \                               },
            \               '<leader>yh':  {
            \                               'cmdstart'  :'noremap <silent>',
            \                               'cmdend'    :':rightbelow vertical YcmCompleter GoToInclude<CR>',
            \                               'desc'      :'右窗口中打开header文件',
            \                               },
            \               '<leader>yth':  {
            \                               'cmdstart'  :'noremap <silent>',
            \                               'cmdend'    :':tab YcmCompleter GoToInclude<CR>',
            \                               'desc'      :'在新tab中口打开header文件',
            \                               },
            \               '<leader>yp':  {
            \                               'cmdstart'  :'noremap <silent>',
            \                               'cmdend'    :':YcmCompleter GetParent<cr>',
            \                               'desc'      :'显示变量或者方法的parent,support c, cpp, objc, objcpp, cuda',
            \                               },
            \              },
            \}



function! Pluginfo_youcompleteme()
    return s:pluginfo 
endfunction

function! Init_youcompleteme()
    call s:ycm_init()
    if hjenv#IsLinux()
        "call Ycm_lsp_init()
    endif
    call s:echodoc_init()

endfunction

function! s:ycm_init()
    "execute 'set runtimepath+='."$VIMFILES".'../'.'YouCompleteMe'
    let g:ycm_add_preview_to_completeopt = 0
    "禁止设置ycm工作文件大小限制
    "let g:ycm_disable_for_files_larger_than_kb = 2000
    "禁用语法检查
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_min_num_identifier_candidate_chars = 2
    "注释与字符串中的内容也用于补全
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    "在注释输入中也能补全
    let g:ycm_complete_in_comments = 1
    "关闭加载.ycm_extra_conf.py提示
    let g:ycm_confirm_extra_conf = 0
    "映射按键,没有这个会拦截掉tab, 导致其他插件的tab不能用.
    "let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
    "在字符串输入中也能补全
    let g:ycm_complete_in_strings=1
    "从第2个键入字符就开始罗列匹配项
    let g:ycm_min_num_of_chars_for_completion=2
    let g:ycm_semantic_triggers =  {
        \ 'c,cpp,python': ['re!\w{2}'],
        \ }

    set completeopt=menu,menuone,noselect

    "禁止原型预览窗口
    let g:ycm_add_preview_to_completeopt = 0

    if hjenv#IsWindows()
        let g:ycm_global_ycm_extra_conf = 
            \ $VIMFILES . 
            \ '\' .
            \ fnamemodify(g:hjvim_config.path.plugdir,":t") . 
            \ '\YouCompleteMe\third_party\ycmd\.ycm_extra_conf.py'
    elseif hjenv#IsMac()
        let g:ycm_global_ycm_extra_conf = 
            \ $VIMFILES . 
            \ '/' .
            \ fnamemodify(g:hjvim_config.path.plugdir,":t") . 
            \ '/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
    elseif hjenv#IsLinux()
        let g:ycm_global_ycm_extra_conf = 
            \ $VIMFILES . 
            \ '/' .
            \ fnamemodify(g:hjvim_config.path.plugdir,":t") . 
            \ '/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
    endif
   
    " 设置白名单，禁止其他类型文件自动补全
    "
    let g:ycm_filetype_whitelist = {}
    let g:ycm_filetype_whitelist = { 
        \ "asm":1,
        \ "c":1,
        \ "cc":1,
        \ "cpp":1, 
        \ "python":1,
        \ "sh":1,
        \ "zsh":0,
        \ "vim":1,
        \ "make":1,
        \ "cmake":1,
        \ "json":0,
        \ "markdown":1,
        \ "ps1":0,
        \ }

    let g:ycm_goto_buffer_command = 'split-or-existing-window'

    "" 以下参考https://clang.llvm.org/extra/clangd/Installation.html，设置ycm参数
    "" YouCompleteMe supports clangd. However, clangd support is not turned on by default, so you must install YouCompleteMe with install.py --clangd-completer.
    "" We recommend changing a couple of YCM’s default settings. In .vimrc add:
    "" Let clangd fully control code completion
    "let g:ycm_clangd_uses_ycmd_caching = 0
    "" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
    "let g:ycm_clangd_binary_path = exepath("clangd")
    "let g:ycm_clangd_args = ['-log=verbose', '-pretty']

endfunction

function! Ycm_lsp_init()
    let s:lsp = g:hjvim_config.path.ycmlsp_dir
    let g:ycm_language_server = [
    \ {
    \   'name': 'bash',
    \   'cmdline': [ 'node', expand( s:lsp . '/bash/node_modules/.bin/bash-language-server' ), 'start' ],
    \   'filetypes': [ 'sh', 'bash' ],
    \ },
    \ {
    \   'name': 'json',
    \   'cmdline': [ 'node', expand( s:lsp . '/json/node_modules/.bin/vscode-json-languageserver' ), '--stdio' ],
    \   'filetypes': [ 'json' ],
    \ },
    \ { 'name': 'vim',
    \   'filetypes': [ 'vim' ],
    \   'cmdline': [ expand( s:lsp . '/viml/node_modules/.bin/vim-language-server' ), '--stdio' ]
    \ },
    \ ]

endfunction


function! s:echodoc_init()
    "for echodoc
    let g:echodoc_enable_at_startup = 1
endfunction
"            \               '<leader>yj':  {
"            \                               'cmdstart'  :'noremap <silent>',
"            \                               'cmdend'    :':tab YcmCompleter GoToDeclaration<CR>',
"            \                               'desc'      :'新标签页打开声明',
"            \                               },


"    \ {
"    \   'name': 'angular',
"    \   'cmdline': [ 'node' ,
"    \      expand( s:lsp . '/angular/node_modules/@angular/language-server' ),
"    \      '--ngProbeLocations',
"    \      expand( s:lsp . '/angular/node_modules/' ),
"    \      '--tsProbeLocations',
"    \      expand( s:lsp . '/angular/node_modules/' ),
"    \      '--stdio' ],
"    \   'filetypes': [ 'ts','html' ],
"    \ }
"    \ {
"    \   'name': 'bash',
"    \   'cmdline': [ 'node', expand( s:lsp . '/bash/node_modules/.bin/bash-language-server' ), 'start' ],
"    \   'filetypes': [ 'sh', 'bash' ],
"    \ },
"    \ {
"    \   'name': 'dart',
"    \   'cmdline': [ 'dart', expand( s:lsp . '/dart/analysis_server.dart.snapshot' ), '--lsp' ],
"    \   'filetypes': [ 'dart' ],
"    \ },
"    \ {
"    \   'name': 'groovy',
"    \   'cmdline': [ 'java', '-jar', expand( s:lsp . '/groovy/groovy-language-server/build/libs/groovy-language-server-all.jar' ) ],
"    \   'filetypes': [ 'groovy' ]
"    \ },
"    \ {
"    \   'name': 'yaml',
"    \   'cmdline': [ 'node', expand( s:lsp . '/yaml/node_modules/.bin/yaml-language-server' ), '--stdio' ],
"    \   'filetypes': [ 'yaml' ],
"    \ },
"    \ {
"    \   'name': 'php',
"    \   'cmdline': [ 'php', expand( s:lsp . '/php/vendor/bin/php-language-server.php' ) ],
"    \   'filetypes': [ 'php' ],
"    \ },
"    \ {
"    \   'name': 'json',
"    \   'cmdline': [ 'node', expand( s:lsp . '/json/node_modules/.bin/vscode-json-languageserver' ), '--stdio' ],
"    \   'filetypes': [ 'json' ],
"    \ },
"    \ {
"    \   'name': 'ruby',
"    \   'cmdline': [ expand( s:lsp . '/ruby/bin/solargraph' ), 'stdio' ],
"    \   'filetypes': [ 'ruby' ],
"    \ },
"    \ { 'name': 'kotlin',
"    \   'filetypes': [ 'kotlin' ], 
"    \   'cmdline': [ expand( s:lsp . '/kotlin/server/build/install/server/bin/server' ) ],
"    \ },
"    \ { 'name': 'd',
"    \   'filetypes': [ 'd' ], 
"    \   'cmdline': [ expand( s:lsp . '/d/serve-d' ) ],
"    \ },
"    \ { 'name': 'vue',
"    \   'filetypes': [ 'vue' ], 
"    \   'cmdline': [ expand( s:lsp . '/vue/node_modules/.bin/vls' ) ]
"    \ },
"    \ { 'name': 'docker',
"    \   'filetypes': [ 'dockerfile' ], 
"    \   'cmdline': [ expand( s:lsp . '/docker/node_modules/.bin/docker-langserver' ), '--stdio' ]
"    \ },
"    \ { 'name': 'vim',
"    \   'filetypes': [ 'vim' ],
"    \   'cmdline': [ expand( s:lsp . '/viml/node_modules/.bin/vim-language-server' ), '--stdio' ]
"    \ },
"    \ { 'name': 'scala',
"    \   'filetypes': [ 'scala' ],
"    \   'cmdline': [ 'metals-vim' ],
"    \   'project_root_files': [ 'build.sbt' ]
"    \ },
"    \ { 'name': 'purescript',
"    \   'filetypes': [ 'purescript' ],
"    \   'cmdline': [ expand( s:lsp . '/viml/node_modules/.bin/purescript-language-server' ), '--stdio' ]
"    \ },
"    \ { 'name': 'fortran',
"    \   'filetypes': [ 'fortran' ],
"    \   'cmdline': [ 'fortls' ],
"    \ },
"    \ { 'name': 'haskell',
"    \   'filetypes': [ 'haskell', 'hs', 'lhs' ],
"    \   'cmdline': [ 'hie-wrapper', '--lsp' ],
"    \   'project_root_files': [ '.stack.yaml', 'cabal.config', 'package.yaml' ]
"    \ },
"    \ { 'name': 'julia',
"    \   'filetypes': [ 'julia' ],
"    \   'project_root_files': [ 'Project.toml' ],
"    \   'cmdline': <See note below>
"    \ },
"    \ { 'name': 'lua',
"    \   'filetypes': [ 'lua' ],
"    \   'cmdline': [ expand( s:lsp . '/lua/lua-language-server/root/extension/server/bin/macOS/lua-language-server'),
"    \                expand( s:lsp . '/lua/lua-language-server/root/extension/server/main.lua' ) ]
"    \ },
"    \ { 'name': 'rust',
"    \   'filetypes': [ 'rust' ],
"    \   'cmdline': [ expand( s:lsp .  '/rust/rust-analyzer/target/release/rust-analyzer' ) ],
"    \   'project_root_files': [ 'Cargo.toml' ],
"    \ },

