if &buftype ==? 'help'
  " don't highlight any columns
  if exists('+colorcolumn')
    setlocal colorcolumn=
  endif
  " <enter> jumps to the subject under the cursor
  nnoremap <silent> <buffer> <cr> <c-]>
  " <backspace> moves the cursor back to its position before the previous jump
  nnoremap <silent> <buffer> <bs> <c-t>
  " <s> moves the cursor to the next subject
  nnoremap <silent> <buffer> s /\|\zs\S\+\ze\|<cr>
  " <S> moves the cursor to the previous subject
  nnoremap <silent> <buffer> S ?\|\zs\S\+\ze\|<cr>
  " <o> moves the cursor to the next option
  nnoremap <silent> <buffer> o /'\l\{2,\}'<cr>
  " <O> moves the cursor to the previous option
  nnoremap <silent> <buffer> O ?'\l\{2,\}'<cr>
else
  " disable concealing
  if has('conceal')
    setlocal conceallevel=0
  endif
endif
