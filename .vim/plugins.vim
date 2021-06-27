scriptencoding utf-8

" Disable unused built-in plugins
let g:loaded_2html_plugin=1
let g:loaded_getscriptPlugin=1
let g:loaded_logipat=1
let g:loaded_netrwPlugin=1
let g:loaded_rrhelper=1
let g:loaded_vimballPlugin=1

" Enable matchit
if !exists('g:loaded_matchit')
  packadd! matchit
endif

" Enable man pages viewer
if exists(":Man") != 2
  runtime ftplugin/man.vim
endif

call plug#begin('~/.vim/bundles')
Plug 'Lenovsky/nuake'
Plug 'airblade/vim-rooter'
Plug 'ap/vim-css-color', {'for': ['css', 'less', 'scss', 'vim']}
Plug 'chaoren/vim-wordmotion'
Plug 'chrisbra/NrrwRgn', {'on': '<plug>NrrwrgnDo'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'hauleth/vim-backscratch', {'on': ['Scratch', 'Scratchify']}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align', {'on': '<plug>(EasyAlign)'}
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'kocakosm/hilal'
Plug 'kocakosm/vim-kitondro', has('gui_running') ? {} : {'on': []}
Plug 'lervag/vimtex', {'for': ['tex']}
Plug 'mg979/vim-visual-multi'
Plug 'mhinz/vim-signify'
Plug 'preservim/nerdtree', {'tag': '6.9.12', 'on': 'NERDTreeToggle'}
Plug 'romainl/vim-cool'
Plug 'shime/vim-livedown', {'for': ['markdown'], 'do': 'npm -g install livedown'}
Plug 'sukima/xmledit', {'for': ['xml', 'xsd', 'html', 'xhtml']}
Plug 'thinca/vim-visualstar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim', {'on': '<plug>(openbrowser-smart-search)'}
Plug 'w0rp/ale'
Plug 'wincent/terminus', has('gui_running') ? {'on': []} : {}
Plug 'zirrostig/vim-schlepp', {'on': '<plug>Schlepp'}
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons', {'tag': 'v0.11.0'}
call plug#end()

" Netrw configuration
if g:loaded_netrwPlugin
  nnoremap gx :!xdg-open <cWORD> &<cr><cr>
else
  let g:netrw_browsex_viewer='firefox'
  let g:netrw_home=expand('$XDG_DATA_HOME/vim/netrw')
  call mkdir(g:netrw_home, 'p', 0700)
endif

" Ahem... well... set colorscheme
silent! colorscheme hilal

" Vim-airline configuration
set noshowmode
set laststatus=2
let g:airline_theme='base16'
let g:airline_section_c='%t'
let g:airline_powerline_fonts=1
let g:airline#extensions#wordcount#enabled=0
"let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#tabline#fnamemod=':t'
"let g:airline#extensions#tabline#tab_nr_type=1
"let g:airline#extensions#tabline#show_close_button=0
"let g:airline#extensions#tabline#formatter='unique_tail_improved'
"let g:airline#extensions#tabline#left_alt_sep=''
"let g:airline#extensions#tabline#left_sep=''
let g:airline#extensions#whitespace#checks=['indent', 'trailing', 'long']
let g:airline#extensions#whitespace#mixed_indent_algo=2
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#ale#error_symbol='✗ '
let g:airline#extensions#ale#warning_symbol='⚠ '
let g:airline_right_sep=''
let g:airline_left_sep=''
let g:airline_right_alt_sep=''
let g:airline_left_alt_sep=''

" NERDTree configuration
nnoremap <silent> <f5> :NERDTreeToggle<cr>
let g:NERDTreeMinimalUI=1
let g:NERDTreeMouseMode=3
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeHijackNetrw=0
let g:NERDTreeWinSize=32
let g:NERDTreeStatusline=''

" Devicons configuration
"let g:webdevicons_enable_ctrlp=0
"let g:webdevicons_enable_nerdtree=0
"let g:webdevicons_enable_airline_tabline=0
let g:webdevicons_enable_airline_statusline=0
let g:WebDevIconsNerdTreeBeforeGlyphPadding=''
let g:WebDevIconsNerdTreeAfterGlyphPadding=''
let g:WebDevIconsUnicodeDecorateFolderNodes=0

" Open-browser configuration
nmap <silent> gw <plug>(openbrowser-smart-search)
xmap <silent> gw <plug>(openbrowser-smart-search)

" NrrwRgn configuration
let g:nrrw_rgn_nohl=1
"let g:nrrw_rgn_vert=1
let g:nrrw_rgn_pad=6
let g:nrrw_rgn_wdth=12
let g:nrrw_topbot_leftright='botright'
xmap <silent> <f3> <plug>NrrwrgnDo

" CtrlP configuration
let g:ctrlp_line_prefix=' '
let g:ctrlp_cache_dir=expand('$XDG_DATA_HOME/vim/ctrlp')
call mkdir(g:ctrlp_cache_dir, 'p', 0700)
if executable('ag')
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching=0
elseif executable('fdfind')
  let g:ctrlp_user_command='fdfind -H -L -E ".git" -c never "" %s'
  let g:ctrlp_use_caching=0
else
  let g:ctrlp_clear_cache_on_exit=1
endif
let g:ctrlp_extensions=['tag', 'quickfix', 'line', 'changes', 'autoignore']
"let g:ctrlp_match_window='top,order:ttb,min:0,max:20'
let g:ctrlp_max_history=0
let g:ctrlp_match_current_file=1
"let g:ctrlp_lazy_update=1
function! s:force_buf_win_enter() abort
  call feedkeys(":doautocmd BufWinEnter | echo ''\<cr>")
endfunction
let g:ctrlp_buffer_func={'exit': expand('<SID>') . 'force_buf_win_enter'}

" Vim-rooter configuration
let g:rooter_cd_cmd='lcd'
let g:rooter_silent_chdir=1
let g:rooter_resolve_links=1
let g:rooter_change_directory_for_non_project_files='current'
let g:rooter_patterns=['pom.xml', 'package.json', 'Makefile', 'makefile']
let g:rooter_patterns+=['.hg/', '.git/']

" Auto-pairs configuration
augroup AutoPairs
  autocmd!
  autocmd Filetype vim let b:AutoPairs=filter(g:AutoPairs, "v:key !~# '\"'")
augroup END

" Vim-visualstar configuration
let g:visualstar_extra_commands='gN'

" Vim-kitondro configuration
if has('gui_running')
  let s:types = ['nerdtree', 'diff', 'qf', 'vim-plug', 'netrw', 'ctrlp', 'dirvish']
  function! s:set_cursor_visibility() abort
    if index(s:types, getbufvar('%', '&filetype')) > -1
      call kitondro#hide_cursor()
    else
      call kitondro#show_cursor()
    endif
  endfunction
  augroup Kitondro
    autocmd!
    autocmd BufWinEnter,BufEnter,FileType * call <sid>set_cursor_visibility()
  augroup END
endif

" Vim-livedown configuration
let g:livedown_autorun=1
let g:livedown_open=1
let g:livedown_port=10042
let g:livedown_browser='firefox -P livedown'

" Vim-signify configuration
let g:signify_vcs_list=['git', 'hg']
"let g:signify_disable_by_default=0
let s:signify_sign='∙'
"let s:signify_sign='❙'
let g:signify_sign_add=s:signify_sign
let g:signify_sign_delete=s:signify_sign
let g:signify_sign_delete_first_line=s:signify_sign
let g:signify_sign_change=s:signify_sign
let g:signify_sign_changedelete=g:signify_sign_change
let g:signify_sign_show_count=0
let g:signify_sign_show_text=1

" ALE configuration
let g:ale_sign_warning='⚠'
let g:ale_sign_error='✗'
let g:ale_set_loclist=0
let g:ale_set_quickfix=0
let g:ale_history_enabled=0
let g:ale_echo_msg_error_str='✗'
let g:ale_echo_msg_warning_str='⚠'
let g:ale_echo_msg_format='[%linter%] %severity% %s'

" Vim-schlepp configuration
xmap <silent> <s-a-up> <plug>SchleppUp
xmap <silent> <s-a-down> <plug>SchleppDown
xmap <silent> <s-a-left> <plug>SchleppLeft
xmap <silent> <s-a-right> <plug>SchleppRight
xmap <silent> <s-a-d> <plug>SchleppDup
"let g:Schlepp#allowSquishingLines=1
"let g:Schlepp#allowSquishingBlocks=1
let g:Schlepp#trimWS=0
let g:Schlepp#reindent=1
"let g:Schlepp#dupTrimWS=1
let g:Schlepp#dupLinesDir='down'
let g:Schlepp#dupBlockDir='right'

" Vim-easy-align configuration
xmap <silent> ga <plug>(EasyAlign)
nmap <silent> ga <plug>(EasyAlign)

" Vimtex configuration
let g:tex_flavor='latex'
let g:vimtex_enabled=1
let g:vimtex_view_method='mupdf'
let g:vimtex_quickfix_mode=0
augroup Vimtex
  autocmd!
  autocmd User VimtexEventQuit call vimtex#compiler#clean(0)
  autocmd User VimtexEventInitPost call vimtex#compiler#compile()
augroup END

" Nuake configuration
let g:nuake_position='top'
let g:nuake_size=0.33
let g:nuake_per_tab=0
nnoremap <f4> :Nuake<cr>
inoremap <f4> <c-\><c-n>:Nuake<cr>
tnoremap <f4> <c-\><c-n>:Nuake<cr>

" Vim-dirvish configuration
augroup Dirvish
  autocmd!
  autocmd FileType dirvish setlocal nonumber | setlocal signcolumn=yes
augroup END

" Vim-sneak configuration
let g:sneak#label=1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Vim-cool configuration
set hlsearch

" Vstats.vim configuration
xmap <silent> ++ <plug>(vstats)
nmap <silent> ++ ggVG<plug>(vstats)

" Zoom.vim configuration
nmap <silent> <c-w>o <plug>(zoom)
nmap <silent> <c-w><c-o> <plug>(zoom)

" Sticky-buffers.vim configuration
let g:sticky_buffers_exclude_filetypes=['help', 'netrw', 'dirvish']
