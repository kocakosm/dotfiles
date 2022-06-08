augroup Fugitive
  autocmd!
  autocmd Filetype fugitive
        \ setlocal bufhidden=hide nonumber cursorline signcolumn=yes nobuflisted textwidth=0 |
        \ call ftplugin#append_undo_cmd('bufhidden< number< cursorline< signcolumn< buflisted< textwidth<')
augroup END
