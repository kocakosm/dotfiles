function! s:auto_close()
  for i in range(1, winnr('$'))
    if getbufvar(winbufnr(i), '&modifiable') | return | endif
  endfor
  for _ in range(winnr('$')) | q | endfor
endfunction

augroup AutoClose
  autocmd!
  autocmd WinEnter * call <sid>auto_close()
augroup END
