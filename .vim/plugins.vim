scriptencoding utf-8

"--------------------------------------"
"---------  Built-in plugins  ---------"
"--------------------------------------"

" Disable unused built-in plugins
let g:loaded_2html_plugin=1
let g:loaded_getscriptPlugin=1
let g:loaded_logipat=1
let g:loaded_netrwPlugin=1
let g:loaded_rrhelper=1
let g:loaded_vimballPlugin=1
let g:loaded_matchit=1

" Enable matchit
" if !exists('g:loaded_matchit')
"   packadd! matchit
" endif

" Enable man pages viewer
if exists(":Man") != 2
  runtime ftplugin/man.vim
endif

" Netrw configuration
if g:loaded_netrwPlugin && executable('xdg-open')
  " emulate ntrw's gx with xdg-open
  function! s:xdg_open(url) abort
    silent! let result = systemlist('xdg-open ' . a:url)
    if v:shell_error
      let msg = trim(split(join(result, ' '), ':')[-1])
      echohl ErrorMsg | echomsg msg | echohl None
    endif
  endfunction
  function! s:get_last_visual_selection() abort
    let tmp_register = 'a'
    let register_content = getreg(tmp_register)
    let register_type = getregtype(tmp_register)
    execute 'silent! normal! gv"' . tmp_register . 'ygv'
    let selection = getreg(tmp_register)
    call setreg(tmp_register, register_content, register_type)
    return selection
  endfunction
  nnoremap <silent> gx :call <sid>xdg_open(expand('<cWORD>'))<cr>
  xnoremap <silent> gx :<c-u> call <sid>xdg_open(<sid>get_last_visual_selection())<cr>
else
  let g:netrw_browsex_viewer='firefox'
  let g:netrw_home=expand('$XDG_DATA_HOME/vim/netrw')
  call mkdir(g:netrw_home, 'p', 0700)
endif

"------------------------------------"
"---------  Custom plugins  ---------"
"------------------------------------"

" Vstats.vim configuration
xmap <silent> ++ <plug>(vstats)
nmap <silent> ++ ggVG<plug>(vstats)

" Zoom.vim configuration
nmap <silent> <c-w>o <plug>(zoom#toggle)
nmap <silent> <c-w><c-o> <plug>(zoom#toggle)
augroup ZoomOut
  autocmd!
  autocmd User ZoomOutPre :StickyBuffersOff
  autocmd User ZoomOutPost :StickyBuffersOn
augroup END

" Cursor-hold-delay.vim configuration
set updatetime=10000
let g:cursor_hold_delay=100

" Sticky-buffers.vim configuration
let g:sticky_buffers_exclude_filetypes=['help', 'dirvish']

"-----------------------------------------"
"---------  Third-party plugins  ---------"
"-----------------------------------------"

" Install vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('$XDG_DATA_HOME/vim/plugins')
Plug 'Lenovsky/nuake', {'on': 'Nuake'}
Plug 'airblade/vim-rooter'
Plug 'andymass/vim-matchup'
Plug 'ap/vim-css-color', {'for': ['css', 'less', 'scss', 'vim']}
Plug 'chaoren/vim-wordmotion'
Plug 'chrisbra/NrrwRgn', {'on': '<plug>NrrwrgnDo'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align', {'on': '<plug>(EasyAlign)'}
Plug 'justinmk/vim-dirvish'
Plug 'kocakosm/hilal'
Plug 'kocakosm/vim-kitondro', has('gui_running') ? {} : {'on': []}
Plug 'lervag/vimtex', {'for': ['tex']}
Plug 'mg979/vim-visual-multi'
Plug 'mhinz/vim-signify'
Plug 'prabirshrestha/vim-lsp' | Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'| Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'preservim/nerdtree', {'tag': '*', 'on': 'NERDTreeToggle'}
Plug 'romainl/vim-cool'
Plug 'shime/vim-livedown', {'for': ['markdown'], 'do': 'npm -g install livedown'}
Plug 'sukima/xmledit', {'for': ['xml', 'xsd', 'html', 'xhtml']}
Plug 'thinca/vim-visualstar'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim', {'on': '<plug>(openbrowser-smart-search)'}
Plug 'wellle/targets.vim'
Plug 'wincent/terminus', has('gui_running') ? {'on': []} : {}
Plug 'zirrostig/vim-schlepp', {'on': '<plug>Schlepp'}
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons', {'tag': 'v0.11.0'}
call plug#end()

for plugin in keys(g:plugs)
  let plugin_name = substitute(tolower(plugin), '^\(n\)\?vim-', '', '')
  let plugin_name = substitute(plugin_name, '[\.-]\(n\)\?vim$', '', '')
  let plugin_conf = expand($HOME . '/.vim/plugins/' . plugin_name .'.vim')
  if filereadable(plugin_conf)
    execute 'source ' . plugin_conf
  endif
endfor
