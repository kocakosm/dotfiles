" Don't show line numbers
setlocal nonumber

" Highlight the current line
setlocal cursorline
setlocal cursorlineopt=both

" Unlist the quickfix buffer
setlocal nobuflisted

" Do not highlight any column
setlocal colorcolumn=

" Move the window to the very bottom, using the full width of the screen
wincmd J

" Undo commands
call ftplugin#append_undo_cmd('setlocal number< cursorline< cursorlineopt< buflisted< colorcolumn<')
