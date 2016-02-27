" Enable matchit (built-in plugin)
runtime macros/matchit.vim

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  source ~/.vim/autoload/plug.vim
endif

call plug#begin('~/.vim/bundles')
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  Plug 'Valloric/MatchTagAlways', { 'for': ['xml', 'html', 'xhtml'] }
  Plug 'Yggdroot/indentLine'
  Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'scss', 'vim'] }
  Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
  Plug 'chrisbra/NrrwRgn'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'ervandew/supertab'
  Plug 'godlygeek/csapprox'
  Plug 'itspriddle/ZoomWin'
  Plug 'jiangmiao/auto-pairs'
  Plug 'kocakosm/hilal'
  Plug 'ludovicchabant/vim-lawrencium'
  Plug 'majutsushi/tagbar'
  Plug 'mikelue/vim-maven-plugin', { 'for': 'java' }
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/syntastic'
  Plug 'sheerun/vim-polyglot'
  Plug 'sjl/gundo.vim'
  Plug 'sukima/xmledit', { 'for': ['xml', 'html', 'xhtml'] }
  Plug 'terryma/vim-multiple-cursors'
  Plug 'thinca/vim-visualstar'
  Plug 'tpope/vim-eunuch'
  Plug 'tyru/open-browser.vim'
  Plug 'vim-jp/vim-java', { 'for': 'java' }
  Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'
call plug#end()

" Alternative plugins:
" ctrlpvim/ctrlp.vim: Shougo/unite.vim
" scrooloose/nerdtree: Shougo/vimfiler.vim
" scrooloose/nerdcommenter: tpope/vim-commentary (simpler, though less powerful)
" jiangmiao/auto-pairs: Raimondi/delimitMate (with let delimitMate_expand_cr=1)
" mikelue/vim-maven-plugin: JalaiAmitahl/maven-compiler.vim + airblade/vim-rooter
" SirVer/ultisnips: garbas/vim-snipmate (simpler, though less powerful)

" Other great plugins:
" Xuyuanp/nerdtree-git-plugin
" artur-shaik/vim-javacomplete2
" chrisbra/unicode.vim
" davidhalter/jedi-vim
" gregsexton/VimCalc
" gregsexton/gitv
" jeetsukumaran/vim-indentwise
" jistr/vim-nerdtree-tabs
" justinmk/vim-gtfo
" kien/rainbow_parentheses.vim
" mattn/calendar-vim
" mattn/vim-terminal
" mhinz/vim-rfc
" mhinz/vim-signify
" mhinz/vim-startify
" michaeljsmith/vim-indent-object
" suan/vim-instant-markdown
" ternjs/tern_for_vim
" tpope/vim-dispatch
" tpope/vim-fugitive
" tpope/vim-speeddating
" vim-expand-region
" vim-scripts/bufkill.vim
" whatyouhide/vim-lengthmatters
" zhaocai/GoldenView.Vim

" Airline configuration
set noshowmode
set laststatus=2
let g:airline_theme='luna'
let g:airline_section_c='%t'
let g:airline_powerline_fonts=1
let g:airline#extensions#wordcount#enabled=0
"let g:airline#extensions#tagbar#enabled=0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#tab_nr_type=1
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#formatter='unique_tail_improved'
let g:airline#extensions#whitespace#checks=['indent', 'trailing', 'long']
let g:airline#extensions#whitespace#mixed_indent_algo=2
"let g:airline#extensions#tabline#left_alt_sep=''
"let g:airline#extensions#tabline#left_sep=''
"let g:airline_right_sep=''
"let g:airline_left_sep=''

" NERDTree configuration
nnoremap <F5> :GundoHide<CR>:NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeMouseMode=3
let NERDTreeHighlightCursorline=1

" Gundo configuration
nnoremap <F9> :NERDTreeClose<CR>:GundoToggle<CR>
let g:gundo_help=0
let g:gundo_right=1
let g:gundo_width=31
let g:gundo_close_on_revert=1

" IndentLine configuration
let g:indentLine_char='┊'
let g:indentLine_color_gui='#1f2a2a'

" Devicons configuration
"let g:webdevicons_enable_airline_tabline=0
"let g:webdevicons_enable_nerdtree=0
let g:WebDevIconsNerdTreeAfterGlyphPadding=' '
"let g:WebDevIconsUnicodeDecorateFolderNodes=1

" Open-browser configuration
nmap <leader>b <Plug>(openbrowser-smart-search)
vmap <leader>b <Plug>(openbrowser-smart-search)

" NrrwRgn configuration
let g:nrrw_rgn_nohl=1
"let g:nrrw_rgn_vert=1
let g:nrrw_rgn_pad=6
let g:nrrw_rgn_wdth=12
let g:nrrw_topbot_leftright='botright'
xmap <F3> <Plug>NrrwrgnDo

" Tagbar configuration
nmap <F10> :TagbarToggle<CR>
let g:tagbar_compact=1
"let g:tagbar_width=30
let g:tagbar_zoomwidth=0
"let g:tagbar_autoclose=1
"let g:tagbar_autofocus=1
"let g:tagbar_sort=0
"let g:tagbar_indent=1
"let g:tagbar_hide_nonpublic=1
let g:tagbar_singleclick=1
let g:tagbar_iconchars=['▸', '▾']
"autocmd FileType java,javascript nested :TagbarOpen

" Maven plugin configuration
let g:maven_auto_chdir=1

" UltiSnips configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
"let g:UltiSnipsEditSplit="vertical"
