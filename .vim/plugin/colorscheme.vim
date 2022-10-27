augroup Colorscheme
  autocmd!
  autocmd ColorScheme * call <sid>on_colorscheme(expand('<amatch>'))
  autocmd BufWinEnter NERD_tree_1 ++once set wincolor=NerdTree
augroup END

function! s:on_colorscheme(colorscheme) abort
  let f = expand('<SID>') . a:colorscheme
  if exists('*' . f) | execute 'call ' . f . '()' | endif
endfunction

function! s:hilal() abort
  highlight NerdTree guibg=#1c242c
  highlight VertSplit term=NONE cterm=NONE guibg=#1a2027 guifg=#0e141c
  highlight StatusLine term=NONE cterm=NONE guibg=#1a2027
  highlight StatusLineNC term=NONE cterm=NONE guibg=#1a2027
  highlight StatusLineTerm term=NONE cterm=NONE guibg=#1a2027
  highlight StatusLineTermNC term=NONE cterm=NONE guibg=#1a2027
  highlight CursorLine term=NONE cterm=NONE
  highlight CursorLineNr term=NONE cterm=NONE guibg=NONE
  highlight CurSearch guibg=#e9d5c1 guifg=#695541
  highlight Cursor guibg=NONE guifg=NONE gui=reverse
endfunction

silent! colorscheme hilal
