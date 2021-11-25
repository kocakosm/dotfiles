" Don't show line numbers
setlocal nonumber

" Highlight the current line
setlocal cursorline

" Hide the quickfix buffer when it is no longer displayed
setlocal bufhidden=hide

" Unlist the quickfix buffer
setlocal nobuflisted

" Move the window to the very bottom, using the full width of the screen
wincmd J

" Undo commands
let b:undo_ftplugin = 'setlocal number< cursorline< bufhidden< buflisted<'
