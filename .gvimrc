" Activate right-click's contextual menu
set mousemodel=popup
"set mousemodel=popup_setpos

" GUI specific font
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 11
"set guifont=Deja\ Vu\ Sans\ Mono\ for\ Powerline\ 11

" Line spacing
set linespace=2

" Remove the toolbar
set guioptions-=T

" Remove the right scrollbar
set guioptions-=r
set guioptions-=R

" Remove the left scrollbar
set guioptions-=l
set guioptions-=L

" Remove the menu
set guioptions-=m

" Disable menu tearoff
set guioptions-=t

" Custom tabs label
set guitablabel=%t\ %m

" Bells
"set errorbells
"set visualbell

" Set window position, height and width
augroup Window
  autocmd!
  autocmd GUIEnter * winpos 120 40
  autocmd GUIEnter * set lines=33 columns=124
augroup END

" Highlight the current line in insert mode
"augroup HighlightLine
"  autocmd!
"  autocmd InsertLeave * set nocursorline
"  autocmd InsertEnter * set cursorline
"augroup END

" Quickly change font size
command! BiggerFont :let &guifont=substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
command! SmallerFont :let &guifont=substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')
