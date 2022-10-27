augroup Fugitive
  autocmd!
  autocmd FileType fugitive
        \ setlocal bufhidden=hide nonumber cursorline cursorlineopt=both signcolumn=yes nobuflisted textwidth=0 |
        \ call ftplugin#append_undo_cmd('setlocal bufhidden< number< cursorline< cursorlineopt< signcolumn< buflisted< textwidth<')
augroup END
