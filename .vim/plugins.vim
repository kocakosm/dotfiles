" Disable unused built-in plugins
let g:loaded_2html_plugin=1
let g:loaded_getscriptPlugin=1
let g:loaded_netrwPlugin=1
let g:loaded_vimballPlugin=1

" Enable matchit (built-in plugin)
if !exists('g:loaded_matchit')
  runtime macros/matchit.vim
endif

call plug#begin('~/.vim/bundles')
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color', {'for': ['css', 'less', 'scss', 'vim']}
Plug 'chrisbra/NrrwRgn'
Plug 'airblade/vim-rooter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/csapprox', has('gui_running') ? {'on': []} : {}
Plug 'itspriddle/ZoomWin'
Plug 'jiangmiao/auto-pairs'
Plug 'kocakosm/hilal'
Plug 'kocakosm/vim-kitondro', has('gui_running') ? {} : {'on': []}
Plug 'lambdalisue/vim-fullscreen'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sjl/gundo.vim'
Plug 'sukima/xmledit', {'for': ['xml', 'html', 'xhtml']}
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-visualstar'
Plug 'tyru/open-browser.vim'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons', has('gui_running') ? {} : {'on': []}
call plug#end()

" Ahem... well... set colorscheme
silent! colorscheme hilal

" Vim-airline configuration
set noshowmode
set laststatus=2
let g:airline_theme='lucius'
let g:airline_section_c='%t'
let g:airline_powerline_fonts=1
let g:airline#extensions#wordcount#enabled=0
let g:airline#extensions#syntastic#enabled=0
"let g:airline#extensions#tagbar#enabled=0
"let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#tabline#fnamemod=':t'
"let g:airline#extensions#tabline#tab_nr_type=1
"let g:airline#extensions#tabline#show_close_button=0
"let g:airline#extensions#tabline#formatter='unique_tail_improved'
"let g:airline#extensions#tabline#left_alt_sep=''
"let g:airline#extensions#tabline#left_sep=''
let g:airline#extensions#whitespace#checks=['indent', 'trailing', 'long']
let g:airline#extensions#whitespace#mixed_indent_algo=2
let g:airline_right_sep=''
let g:airline_left_sep=''
let g:airline_right_alt_sep=''
let g:airline_left_alt_sep=''

" NERDTree configuration
nnoremap <silent> <f5> :NERDTreeToggle<cr>
let NERDTreeMinimalUI=1
let NERDTreeMouseMode=3
let NERDTreeHighlightCursorline=1

" Gundo configuration
nnoremap <silent> <f9> :GundoToggle<cr>
let g:gundo_help=0
let g:gundo_right=1
let g:gundo_width=26
let g:gundo_preview_bottom=1
let g:gundo_preview_height=10
let g:gundo_close_on_revert=1
let g:gundo_prefer_python3=1
augroup Gundo
  autocmd!
  autocmd BufNewFile __Gundo__ setlocal cursorline
augroup END

" IndentLine configuration
let g:indentLine_char='│'
let g:indentLine_color_gui='#1a1e22'
let g:indentLine_fileTypeExclude=['java', 'make', 'txt', 'help', '']

" Devicons configuration
"let g:webdevicons_enable_ctrlp=0
"let g:webdevicons_enable_nerdtree=0
"let g:webdevicons_enable_airline_tabline=0
let g:webdevicons_enable_airline_statusline=0
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
"augroup Tagbar
"  autocmd!
"  autocmd FileType java,javascript nested :TagbarOpen
"augroup END

" UltiSnips configuration
let g:UltiSnipsExpandTrigger='<c-space>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-tab>'
"let g:UltiSnipsEditSplit='vertical'

" Vim-rooter configuration
let g:rooter_use_lcd=1
let g:rooter_silent_chdir=1
let g:rooter_resolve_links=1
let g:rooter_change_directory_for_non_project_files='current'
let g:rooter_patterns=['pom.xml', 'package.json', 'Makefile', 'makefile']
let g:rooter_patterns+=['.hg/', '.git', '.git/']

" Supertab configuration
let g:SuperTabNoCompleteAfter=['^', ',', '\s']
let g:SuperTabMappingForward='<c-space>'
let g:SuperTabMappingBackward='<s-c-space>'
let g:SuperTabLongestEnhanced=1
let g:SuperTabDefaultCompletionType='context'
let g:SuperTabContextDefaultCompletionType='<c-n>'
let g:SuperTabRetainCompletionDuration='completion'

" Vim-fullscreen configuration
let fullscreen#enable_default_keymap=0
nnoremap <silent> <f11> :FullscreenToggle<cr>
inoremap <silent> <f11> <c-o>:FullscreenToggle<cr>

" Vim-visualstar configuration
let visualstar_extra_commands='gN'
