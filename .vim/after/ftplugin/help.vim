if &buftype ==# 'help'
  " Don't highlight any columns
  setlocal colorcolumn=
  " Undo commands
  call ftplugin#append_undo_cmd('setlocal colorcolumn<')
else
  " Disable concealing
  setlocal conceallevel=0
  " Undo commands
  call ftplugin#append_undo_cmd('setlocal conceallevel<')
endif
