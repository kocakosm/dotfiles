augroup Colorscheme
  autocmd!
  autocmd ColorScheme * call <sid>on_colorscheme(expand('<amatch>'))
  " TODO: neovim support
  if exists('+wincolor')
    autocmd BufWinEnter NERD_tree_1 ++once set wincolor=NerdTree
  endif
augroup END

function! s:on_colorscheme(colorscheme) abort
  let f = expand('<SID>') . a:colorscheme
  if exists('*' . f) | execute 'call ' . f . '()' | endif
endfunction

function! s:hilal() abort
  hi NerdTree guibg=#1c242c
  hi VertSplit guibg=#15191c guifg=#1a2027
  hi StatusLine term=NONE cterm=NONE guibg=#1a2027
  hi StatusLineNC term=NONE cterm=NONE guibg=#1a2027
  hi StatusLineTerm term=NONE cterm=NONE guibg=#1a2027
  hi StatusLineTermNC term=NONE cterm=NONE guibg=#1a2027
  hi CursorLine term=NONE cterm=NONE
  hi CursorLineNr term=NONE cterm=NONE
  hi CurSearch guibg=#e9d5c1 guifg=#695541
  hi Cursor guibg=NONE guifg=NONE gui=reverse
endfunction

silent! colorscheme hilal
