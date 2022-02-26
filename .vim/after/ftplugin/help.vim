if &buftype ==# 'help'
  " don't highlight any columns
  setlocal colorcolumn=
  " <enter> jumps to the subject under the cursor
  nnoremap <silent> <buffer> <cr> <c-]>
  " <backspace> moves the cursor back to its position before the previous jump
  nnoremap <silent> <buffer> <bs> <c-t>
else
  " disable concealing
  setlocal conceallevel=0
endif

" Undo commands
call ftplugin#append_undo_cmd('nunmap <buffer> <cr>')
call ftplugin#append_undo_cmd('nunmap <buffer> <bs>')
call ftplugin#append_undo_cmd('setlocal conceallevel< colorcolumn<')
