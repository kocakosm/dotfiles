vim9script

import autoload '../autoload/cursor.vim'

const file_types = [
  'nerdtree', 'diff', 'qf', 'vim-plug', 'dirvish', 'man', 'fugitive'
]

def CursorAutoHide(): void
  if index(file_types, &filetype) > -1
    cursor.Hide()
  else
    cursor.Show()
  endif
enddef

augroup CursorAutoHide
  autocmd!
  autocmd CmdLineEnter * cursor.Show()
  autocmd BufWinEnter,BufEnter,FileType,CmdLineLeave * CursorAutoHide()
  autocmd User SpyglassOpen set nocursorline | cursor.Hide()
  autocmd User SpyglassClose set cursorline | CursorAutoHide()
augroup END
