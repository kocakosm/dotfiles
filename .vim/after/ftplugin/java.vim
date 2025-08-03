" Do not highlight html and markdown in javadocs
let g:java_ignore_html = 1
let g:java_ignore_markdown = 1

" Automatically insert the comment leader after hitting <Enter> in insert mode
setlocal formatoptions+=r

" Automatically insert the comment leader after hitting 'o'/'O' in normal mode
setlocal formatoptions+=o

" Undo commands
call ftplugin#append_undo_cmd('setlocal formatoptions<')
