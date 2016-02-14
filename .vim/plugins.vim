" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  source ~/.vim/autoload/plug.vim
endif

call plug#begin('~/.vim/bundles')
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  Plug 'Valloric/MatchTagAlways'
  Plug 'Yggdroot/indentLine'
  Plug 'ap/vim-css-color'
  Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'ervandew/supertab'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'kocakosm/hilal'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'sjl/gundo.vim'
  Plug 'sukima/xmledit'
  Plug 'terryma/vim-multiple-cursors'
  "Plug 'kien/rainbow_parentheses.vim'
  "Plug 'godlygeek/csapprox'
  "Plug 'chrisbra/unicode.vim'
  "Plug 'tpope/vim-dispatch'
  "Plug 'tpope/vim-commentary'
  "Plug 'mhinz/vim-rfc'
  "Plug 'mhinz/vim-startify'
call plug#end()

" Airline configuration
if has('gui_running')
  set noshowmode
  set laststatus=2
  let g:airline#extensions#tabline#enabled=1
  let g:airline#extensions#tabline#fnamemod=':t'
  let g:airline_powerline_fonts=1
  let g:airline_theme='luna'
  let g:airline#extensions#whitespace#mixed_indent_algo=1
else
  autocmd VimEnter * AirlineToggle
endif

" NERDTree configuration
nnoremap <F5> :GundoHide<CR>:NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeHighlightCursorline=0
let NERDTreeMouseMode=3
let NERDTreeHighlightCursorline=1

" Gundo configuration
nnoremap <F9> :NERDTreeClose<CR>:GundoToggle<CR>
let g:gundo_help=0
let g:gundo_close_on_revert=1
let g:gundo_right=1
let g:gundo_width=31

" IndentLine configuration
let g:indentLine_char = '┊'
let g:indentLine_color_gui = '#1f2a2a'
