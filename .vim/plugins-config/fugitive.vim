augroup Fugitive
  autocmd!
  autocmd FileType fugitive
        \ setlocal bufhidden=hide nonumber cursorline signcolumn=yes nobuflisted textwidth=0 |
        \ call ftplugin#append_undo_cmd('setlocal bufhidden< number< cursorline< signcolumn< buflisted< textwidth<')
augroup END
