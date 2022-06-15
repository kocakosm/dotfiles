if &buftype ==# 'help'
  " don't highlight any columns
  setlocal colorcolumn=
  " <enter> jumps to the subject under the cursor
  nnoremap <silent> <buffer> <cr> <c-]>
  " <backspace> moves the cursor back to its position before the previous jump
  nnoremap <silent> <buffer> <bs> <c-t>
  " Undo commands
  call ftplugin#append_undo_cmd('setlocal colorcolumn<')
else
  " disable concealing
  setlocal conceallevel=0
  " Undo commands
  call ftplugin#append_undo_cmd('setlocal conceallevel<')
endif
