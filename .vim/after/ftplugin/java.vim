"	Automatically insert the comment leader after hitting <Enter> in insert mode
setlocal formatoptions+=r

" Automatically insert the comment leader after hitting 'o'/'O' in normal mode
setlocal formatoptions+=o

" Undo commands
call ftplugin#append_undo_cmd('setlocal formatoptions<')
