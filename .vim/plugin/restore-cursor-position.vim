" When opening a file, jumps to the last known cursor position if possible

function! s:restore_cursor_position() abort
  if line("'\"") >= 1 && line("'\"") <= line("$") && &filetype !~# 'commit'
    execute "normal! g`\""
  endif
endfunction

augroup RestoreCursorPosition
  autocmd BufReadPost * call <sid>restore_cursor_position()
augroup END
