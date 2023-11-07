" Don't show line numbers
setlocal nonumber

" Highlight the current line
setlocal cursorline
setlocal cursorlineopt=both

" Unlist the quickfix buffer
setlocal nobuflisted

" Do not highlight any column
setlocal colorcolumn=

" Move the qf window to the very bottom, using the full width of the screen
if win_gettype() == 'quickfix'
  wincmd J
endif

" Undo commands
call ftplugin#append_undo_cmd('setlocal number< cursorline< cursorlineopt< buflisted< colorcolumn<')

" <alt>-<right> switches to the newer list
function! s:newer() abort
  let loc = win_gettype() == 'loclist'
  let cmd = (loc ? 'l' : 'c') . 'newer'
  let Lnr = {n -> (loc ? getloclist(win_getid(), #{nr: n}) : getqflist(#{nr: n})).nr}
  return Lnr(0) >= Lnr('$') ? '' : $"\<cmd>{cmd}\<cr>"
endfunction
nnoremap <silent> <buffer> <expr> <a-right> <sid>newer()

" <alt>-<left> switches to the older list
function! s:older() abort
  let loc = win_gettype() == 'loclist'
  let cmd = (loc ? 'l' : 'c') . 'older'
  let Lnr = {n -> (loc ? getloclist(win_getid(), #{nr: n}) : getqflist(#{nr: n})).nr}
  return Lnr(0) <= 1 ? '' : $"\<cmd>{cmd}\<cr>"
endfunction
nnoremap <silent> <buffer> <expr> <a-left> <sid>older()
