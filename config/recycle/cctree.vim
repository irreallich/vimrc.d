" VIM scripts
" Author: hjwang
" Created Time : 2019年08月14日 星期三 14时40分30秒
" File Name: config/plug_conf/cctree.vim
" Description:
"""
let s:filename = fnamemodify(expand('<sfile>'), ':t:r')
let s:pluginfo = {
            \ 'cmdline' : [
                        \ ['hari-rangarajan/CCTree'],
                        \ ],
            \ 'mode'    : 'normal',
            \ 'func'    : ['Init_cctree'],
            \}
function! Pluginfo_cctree()
    return s:pluginfo 
endfunction

function! Init_cctree()
    let g:CCTreeKeyTraceForwardTree = '<C-\>>' "the symbol in current cursor's forward tree 
    let g:CCTreeKeyTraceReverseTree = '<C-\><'
    let g:CCTreeKeyHilightTree = '<C-\>l' " Static highlighting
    let g:CCTreeKeySaveWindow = '<C-\>y'
    let g:CCTreeKeyToggleWindow = '<C-\>w'
    let g:CCTreeKeyCompressTree = 'zs' " Compress call-tree
    let g:CCTreeKeyDepthPlus = '<C-\>='
    let g:CCTreeKeyDepthMinus = '<C-\>-'
    let g:CCTreeJoinProgCmd = 'PROG_JOIN JOIN_OPT IN_FILES > OUT_FILE'
    let  g:CCTreeJoinProg = 'cat' 
    let  g:CCTreeJoinProgOpts = ''
    "let g:CCTreeUseUTF8Symbols = 1
    "map <F7> :CCTreeLoadXRefDBFromDisk $CCTREE_DB<cr> 
endfunction


