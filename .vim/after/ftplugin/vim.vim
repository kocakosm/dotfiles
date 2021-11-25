" Do not automatically insert the comment leader after hitting <Enter> in insert mode
setlocal formatoptions-=r

" Do not automatically insert the comment leader after hitting 'o'/'O' in normal mode
setlocal formatoptions-=o

" Undo commands
let b:undo_ftplugin = 'setlocal formatoptions<'
