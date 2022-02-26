if !has('gui_running')
  finish
endif

let s:types = ['nerdtree', 'diff', 'qf', 'vim-plug', 'ctrlp', 'dirvish', 'man']

function! s:set_cursor_visibility() abort
  if index(s:types, &filetype) ># -1
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
