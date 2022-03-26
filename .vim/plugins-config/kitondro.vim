if !has('gui_running')
  finish
endif

let s:file_types = [
\  'nerdtree', 'diff', 'qf', 'vim-plug', 'ctrlp', 'dirvish', 'man', 'fugitive'
\]

function! s:set_cursor_visibility() abort
  if index(s:file_types, &filetype) > -1
    call kitondro#hide_cursor()
  else
    call kitondro#show_cursor()
  endif
endfunction

augroup Kitondro
  autocmd!
  autocmd BufWinEnter,BufEnter,FileType,CmdLineLeave * call <sid>set_cursor_visibility()
  autocmd CmdLineEnter * :KitondroShowCursor
augroup END
