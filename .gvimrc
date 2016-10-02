" Enable right-click's contextual menu
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

" Enable visual bell
set visualbell

" Set window position, height and width
augroup Window
  autocmd!
  autocmd GuiEnter * winpos 120 40
  autocmd GuiEnter * set lines=33 columns=124
augroup END

" Easily change font size
command! BiggerFont :let &guifont=substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
command! SmallerFont :let &guifont=substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')
"nnoremap <silent> <c-scrollwheelup> :BiggerFont<cr>
"inoremap <silent> <c-scrollwheelup> <c-o>:BiggerFont<cr>
"nnoremap <silent> <c-scrollwheeldown> :SmallerFont<cr>
"inoremap <silent> <c-scrollwheeldown> <c-o>:SmallerFont<cr>

" Highlight the current line in insert mode
"augroup HighlightLine
"  autocmd!
"  autocmd InsertEnter * set cursorline
"  autocmd InsertLeave * set nocursorline
"augroup END

" Source a local .gvimrc, if available
if filereadable(expand('~/.gvimrc.local'))
  source ~/.gvimrc.local
endif
