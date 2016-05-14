" Enable matchit (built-in plugin)
runtime macros/matchit.vim

call plug#begin('~/.vim/bundles')
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  Plug 'Yggdroot/indentLine'
  Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'scss', 'vim'] }
  Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
  Plug 'chrisbra/NrrwRgn'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'ervandew/supertab'
  Plug 'godlygeek/csapprox', has('gui_running') ? { 'on': [] } : {}
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
  Plug 'ryanoasis/vim-devicons', has('gui_running') ? {} : { 'on': [] }
call plug#end()

" Alternative plugins:
" ctrlpvim/ctrlp.vim: Shougo/unite.vim
" scrooloose/nerdtree: Shougo/vimfiler.vim
" scrooloose/nerdcommenter: tpope/vim-commentary (simpler, though less powerful)
" jiangmiao/auto-pairs: Raimondi/delimitMate (with let delimitMate_expand_cr=1)
" mikelue/vim-maven-plugin: JalaiAmitahl/maven-compiler.vim + airblade/vim-rooter
" SirVer/ultisnips: garbas/vim-snipmate (simpler, though less powerful)

" Other great plugins:
" Quramy/tsuquyomi
" Valloric/MatchTagAlways
" Xuyuanp/nerdtree-git-plugin
" artur-shaik/vim-javacomplete2
" chrisbra/unicode.vim
" davidhalter/jedi-vim
" gregsexton/VimCalc
" gregsexton/gitv
" itchyny/lightline.vim
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
" moll/vim-bbye
" suan/vim-instant-markdown
" ternjs/tern_for_vim
" tpope/vim-dispatch
" tpope/vim-fugitive
" tpope/vim-speeddating
" vim-airline/vim-airline
" vim-airline/vim-airline-themes
" vim-expand-region
" vim-scripts/SyntaxAttr.vim
" vim-scripts/bufkill.vim
" w0ng/vim-hybrid
" whatyouhide/vim-lengthmatters
" zefei/vim-wintabs
" zhaocai/GoldenView.Vim

" Ahem... well... set colorscheme
silent! colorscheme hilal

" NERDTree configuration
nnoremap <silent> <f5> :NERDTreeToggle<cr>
let NERDTreeMinimalUI=1
let NERDTreeMouseMode=3
let NERDTreeHighlightCursorline=1

" Gundo configuration
nnoremap <silent> <f9> :GundoToggle<cr>
let g:gundo_help=0
let g:gundo_right=1
let g:gundo_width=31
let g:gundo_close_on_revert=1

" IndentLine configuration
let g:indentLine_char='│'
let g:indentLine_color_gui='#1a1e22'
let g:indentLine_fileTypeExclude=['java', 'txt']

" Devicons configuration
"let g:webdevicons_enable_airline_tabline=0
"let g:webdevicons_enable_nerdtree=0
let g:WebDevIconsNerdTreeAfterGlyphPadding=' '
"let g:WebDevIconsUnicodeDecorateFolderNodes=1

" Open-browser configuration
nmap <silent> <leader>b <plug>(openbrowser-smart-search)
xmap <silent> <leader>b <plug>(openbrowser-smart-search)

" NrrwRgn configuration
let g:nrrw_rgn_nohl=1
"let g:nrrw_rgn_vert=1
let g:nrrw_rgn_pad=6
let g:nrrw_rgn_wdth=12
let g:nrrw_topbot_leftright='botright'
xmap <silent> <f3> <plug>NrrwrgnDo

" Tagbar configuration
nnoremap <silent> <f10> :TagbarToggle<cr>
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
