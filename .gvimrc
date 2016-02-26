" Activate right-click's contextual menu
set mousemodel=popup
"set mousemodel=popup_setpos

" GUI specific font
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 11
"set guifont=Deja\ Vu\ Sans\ Mono\ for\ Powerline\ 11
set guifont=Inconsolata\ for\ Powerline\ 13

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

" GUI specific colorscheme
"colorscheme hilal

" Bells
"set errorbells
"set visualbell

" Set window position, height and width
set lines=37 columns=124
autocmd GUIEnter * winpos 120 40

" Highlight the current line in edition mode
"autocmd InsertLeave * set nocursorline
"autocmd InsertEnter * set cursorline

" Quickly change font size
command! BiggerFont :let &guifont=substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
command! SmallerFont :let &guifont=substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')
