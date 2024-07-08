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
if win_gettype() ==# 'quickfix'
  wincmd J
endif

" Undo commands
call ftplugin#append_undo_cmd('setlocal number< cursorline< cursorlineopt< buflisted< colorcolumn<')

" <alt>-<right> switches to the newer list
function! s:newer() abort
  execute 'silent! ' . (win_gettype() ==# 'loclist' ? 'l' : 'c') . 'newer'
endfunction
nnoremap <silent> <buffer> <a-right> <cmd>call <sid>newer()<cr>
call ftplugin#append_undo_cmd('silent! nunmap <buffer> <a-right>')

" <alt>-<left> switches to the older list
function! s:older() abort
  execute 'silent! ' . (win_gettype() ==# 'loclist' ? 'l' : 'c') . 'older'
endfunction
nnoremap <silent> <buffer> <a-left> <cmd>call <sid>older()<cr>
call ftplugin#append_undo_cmd('silent! nunmap <buffer> <a-left>')
