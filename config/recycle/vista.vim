" VIM scripts
" Author: hjwang
" Created Time : Fri 11 Oct 2019 07:07:08 AM UTC
" File Name: config/plug_conf/vista.vim
" Description:
"""
" ['liuchengxu/vista.vim',"'on': 'Vista'"],
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['liuchengxu/vista.vim'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_vista'],
            \}
function! Pluginfo_vista()
    return s:pluginfo 
endfunction

function! Init_vista()
    echo "1111111111111111"
    call s:vista_init()
endfunction

function! s:vista_init()
    " basic settings
    let g:vista_sidebar_width = 50

    " How each level is indented and what to prepend.
    " This could make the display more compact or more spacious.
    " e.g., more compact: ["▸ ", ""]
    " Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
    let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

    " Executive used when opening vista sidebar without specifying it.
    " See all the avaliable executives via `:echo g:vista#executives`.
    let g:vista_default_executive = 'ctags'

    " Set the executive for some filetypes explicitly. Use the explicit executive
    " instead of the default one for these filetypes when using `:Vista` without
    " specifying the executive.
    " let g:vista_executive_for = {
    "   \ 'cpp': 'vim_lsp',
    "   \ 'php': 'vim_lsp',
    "   \ }

    " Declare the command including the executable and options used to generate ctags output
    " for some certain filetypes.The file path will be appened to your custom command.
    " For example:
    let g:vista_ctags_cmd = {
          \ 'haskell': 'hasktags -x -o - -c',
          \ }

    " To enable fzf's preview window set g:vista_fzf_preview.
    " The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
    " For example:
    " let g:vista_fzf_preview = ['right:50%']

    " Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
    let g:vista#renderer#enable_icon = 1

    " The default icons can't be suitable for all the filetypes, you can extend it as you wish.
    let g:vista#renderer#icons = {
    \   "function": "\uf794",
    \   "variable": "\uf71b",
    \  }

    " Show the nearest method/function in the statusline
    set statusline+=%{NearestMethodOrFunction()}
    " show the nearest function in your statusline automatically,
    autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

endfunction

function! NearestMethodOrFunction() 
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
