" VIM scripts
" Author: hjwang
" Created Time : 2020年10月16日 星期五 15时33分22秒
" File Name: test/popup.vim
" Description:
" 测试popup代码
"""

	call popup_create("1111111111111111111111111111", #{
		\ filter: 'MyMenuFilter',
		\ callback: 'MyMenuHandler',
		\ })

	func MyMenuFilter(id, key)
	  " 处理快捷键
	  if a:key == 'S'
	     call popup_close(a:id, 1)
	     return 1
	  endif
	  if a:key == 'C'
	     call popup_close(a:id, 2)
	     return 1
	  endif
	  if a:key == 'D'
	     call popup_close(a:id, 3)
	     return 1
	  endif

	  " 没有快捷键，传递给通用过滤
	  return popup_filter_menu(a:id, a:key)
	endfunc
