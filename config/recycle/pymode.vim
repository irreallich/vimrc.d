" VIM scripts
" Author: hjwang
" Created Time : 2019年10月15日 星期二 10时29分22秒
" File Name: config/plug/pymode.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['python-mode/python-mode'," 'for': 'python', 'branch': 'develop' "],
                        \ ],
            \ 'mode'    : 'cmd',
            \ 'func'    : ['Init_pymode'],
            \}
function! Pluginfo_pymode()
    return s:pluginfo 
endfunction

function! Init_pymode()
    let g:pymode_python = 'python3'
    call Pymode_generic()
    call Pymode_moderun(1)
    call Pymode_breakpoint(0)
    call Pymode_virtualenv(0)
    call Pymode_complete(0)
    call Pymode_syntax(0)
    call Pymode_code_check(0)
    
    let g:pymode_options = 0
endfunction

function! Pymode_generic()
    "Turn off plugin's warnings. 
    let g:pymode_warnings = 0
    "Trim unused white spaces on save.
    let g:pymode_trim_whitespaces = 1
    "Enable colorcolumn display at max_line_length.
    let g:pymode_options_colorcolumn = 1
    "Setup pymode |quickfix| window.
    let g:pymode_quickfix_minheight = 3
    let g:pymode_quickfix_maxheight = 6
    "Turns on the documentation script 
    let g:pymode_doc = 1
    "Bind keys to show documentation for current word (selection)
    let g:pymode_doc_bind = 'K'
    "Pymode supports PEP8-compatible python indent.
    "Enable pymode indentation     
    let g:pymode_indent = 0
    "Enable pymode folding 
    let g:pymode_folding = 0
    "Enable pymode-motion
    let g:pymode_motion = 1

endfunction



function! Pymode_moderun(value)
    if a:value == 1
        let g:pymode_run = 1
        let g:pymode_run_bind = '<leader>pg'
    else
        let g:pymode_run = 0
    endif 
endfunction
function! Pymode_breakpoint(value)
    if a:value == 1
        "Enable functionality
        let g:pymode_breakpoint = 1
        "Bind keys
        let g:pymode_breakpoint_bind = '<leader>pb'
        "Manually set breakpoint command (leave empty for automatic detection)
        let g:pymode_breakpoint_cmd = ''
    else
        let g:pymode_breakpoint = 0
    endif 
endfunction
function! Pymode_virtualenv(value)
    if a:value == 1
        let g:pymode_virtualenv = 1
        let g:pymode_virtualenv_path = $VIRTUAL_ENV
    else
        let g:pymode_virtualenv = 0
    endif 
endfunction
function! Pymode_complete(value)
    if a:value == 1
        "Turn on code completion support in the plugin
        let g:pymode_rope_completion = 1
        "Turn on autocompletion when typing a period
        let g:pymode_rope_complete_on_dot = 1
        "Keymap for autocomplete 
        "let g:pymode_rope_completion_bind = '<C-y>'
        "Extended autocompletion (rope could complete 
        "objects which have not been imported) from project 
        let g:pymode_rope_autoimport = 1
        "Load modules to autoimport by default
        let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime']
        "Offer to unresolved import object after completion.
        let g:pymode_rope_autoimport_import_after_complete = 0
    else
        let g:pymode_rope_completion = 0
    endif 
endfunction

function! Pymode_details()
    "Turn on the whole plugin.
    let g:pymode = 1 
    "Add paths to 'sys.path',Value is list of path's strings.
    let g:pymode_paths = []
    "Setup max line length
    let g:pymode_options_max_line_length = 79
    "Set pymode |preview| window height. 
    "Preview window is used to show 
    "documentation and ouput from |pymode-run|.
    let g:pymode_preview_height = &previewheight
    "Set where pymode |preview| window will appear. 
    let g:pymode_preview_position = 'botright'   

   
    "Find definition
    let g:pymode_rope_goto_definition_bind = '<C-c>g'
    "Command for open window when definition has been found
    "Values are (`e`, `new`, `vnew`)
    let g:pymode_rope_goto_definition_cmd = 'new'


endfunction

function! Pymode_refactoring(value)
    if a:value == 1
        "Refactoring,Rename method/function/class/variable in the project
        "Keymap for rename method/function/class/variables under cursor
        let g:pymode_rope_rename_bind = '<C-c>rr'
        "Rename a current module/package ~
        let g:pymode_rope_rename_module_bind = '<C-c>r1r'
        "Imports ~
        "*:PymodeRopeAutoImport* -- Resolve import for element under cursor
        "Organize imports sorts imports, too. It does that according to PEP8. Unused
        "imports will be dropped.
        let g:pymode_rope_organize_imports_bind = '<C-c>ro'
        "Insert import for current word under cursor
        "Should be enabled |'g:pymode_rope_autoimport'|
        let g:pymode_rope_autoimport_bind = '<C-c>ra'
        "convert current module to package
        let g:pymode_rope_module_to_package_bind = '<C-c>r1p'
        "Extract method/variable from selected lines.
        let g:pymode_rope_extract_method_bind = '<C-c>rm'
        let g:pymode_rope_extract_variable_bind = '<C-c>rl'
        "It tries to find the places in which a function can be used and changes the code to call it instead.
        let g:pymode_rope_use_function_bind = '<C-c>ru'
        "It happens when you perform move refactoring on a method of a class.
        "In this refactoring, a method of a class is moved to the class of one
        "of its attributes. The old method will call the new method. If you
        "want to change all of the occurrences of the old method to use the new method you can inline it afterwards.
        let g:pymode_rope_move_bind = '<C-c>rv'
        "Change function signature ~
        let g:pymode_rope_change_signature_bind = '<C-c>rs'
    else
        
    endif
endfunction
function! Pymode_syntax(value)
    if a:value == 1
        "Slower syntax synchronization that is better at handling code blocks in
        "docstrings. Consider disabling this on slower hardware.
        "let g:pymode_syntax_slow_sync = 1
        "Enable all python highlights
        let g:pymode_syntax_all = 1
        "Highlight "print" as a function
        let g:pymode_syntax_print_as_function = 1
        "Highlight "async/await" keywords
        let g:pymode_syntax_highlight_async_await = g:pymode_syntax_all
        "Highlight '=' operator
        let g:pymode_syntax_highlight_equal_operator = g:pymode_syntax_all
        "Highlight '*' operator
        let g:pymode_syntax_highlight_stars_operator = g:pymode_syntax_all
        "Highlight 'self' keyword
        let g:pymode_syntax_highlight_self = g:pymode_syntax_all
        "Highlight indent's errors
        let g:pymode_syntax_indent_errors = g:pymode_syntax_all
        "Highlight space's errors
        let g:pymode_syntax_space_errors = g:pymode_syntax_all
        "Highlight string formatting
        let g:pymode_syntax_string_formatting = g:pymode_syntax_all
        let g:pymode_syntax_string_format = g:pymode_syntax_all
        let g:pymode_syntax_string_templates = g:pymode_syntax_all
        let g:pymode_syntax_doctests = g:pymode_syntax_all
        "Highlight builtin objects (True, False, ...)
        let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
        "Highlight builtin types (str, list, ...)
        let g:pymode_syntax_builtin_types = g:pymode_syntax_all
        "Highlight exceptions (TypeError, ValueError, ...)
        let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
        "Highlight docstrings as pythonDocstring (otherwise as pythonString)
        let g:pymode_syntax_docstrings = g:pymode_syntax_all
        "Turn on pymode syntax
        let g:pymode_syntax = 1
    else
        let g:pymode_syntax = 0
    endif
endfunction

function! Pymode_code_check(value) 
    if a:value == 1
        "Turn on code checking                                           *'g:pymode_lint'*
        let g:pymode_lint = 1

        "Check code on every save (if file has been modified)   *'g:pymode_lint_on_write'*
        let g:pymode_lint_on_write = 1

        "Check code on every save (every)                     *'g:pymode_lint_unmodified'*
        let g:pymode_lint_unmodified = 0

        "Check code when editing (on the fly)                     *'g:pymode_lint_on_fly'*
        let g:pymode_lint_on_fly = 0
        "Show error message if cursor placed at the error line   *'g:pymode_lint_message'*
        let g:pymode_lint_message = 1
        "Default code checkers (you could set several)          *'g:pymode_lint_checkers'*
        let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
        "Values may be chosen from: `pylint`, `pep8`, `mccabe`, `pep257`, `pyflakes`.
        "Skip errors and warnings                                 *'g:pymode_lint_ignore'*
        "E.g. ["W", "E2"] (Skip all Warnings and the Errors starting with E2) etc.
        "let g:pymode_lint_ignore = ["E501", "W",]

        "Select some error or warnings.                           *'g:pymode_lint_select'*
        "By example you disable all warnings starting from 'W', but want to see warning
        "'W0011' and warning 'W430'
        let g:pymode_lint_select = ["E501", "W0011", "W430"]

        "Sort errors by relevance                                   *'g:pymode_lint_sort'*
        "If not empty, errors will be sort by defined relevance
        "E.g. let g:pymode_lint_sort = ['E', 'C', 'I']  " Errors first 'E',
        "after them 'C' and ...
        let g:pymode_lint_sort = []

        "Auto open cwindow (quickfix) if any errors have been found
        "                                                    *'g:pymode_lint_cwindow'*
        let g:pymode_lint_cwindow = 1

        "Place error |signs|                                              *'g:pymode_signs'*
        let g:pymode_lint_signs = 1

        "Definitions for |signs|
        let g:pymode_lint_todo_symbol = 'WW'
        let g:pymode_lint_comment_symbol = 'CC'
        let g:pymode_lint_visual_symbol = 'RR'
        let g:pymode_lint_error_symbol = 'EE'
        let g:pymode_lint_info_symbol = 'II'
        let g:pymode_lint_pyflakes_symbol = 'FF'
    else
        let g:pymode_lint = 0
    endif

endfunction


