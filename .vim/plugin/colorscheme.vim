augroup Colorscheme
  autocmd!
  autocmd ColorScheme * call <sid>on_colorscheme(expand('<amatch>'))
  if exists('+wincolor')
    autocmd BufWinEnter NERD_tree_1 ++once set wincolor=NerdTree
  endif
augroup END

function! s:on_colorscheme(colorscheme) abort
  let f = expand('<SID>') . a:colorscheme
  if exists('*' . f) | execute 'call ' . f . '()' | endif
endfunction

function! s:hilal() abort
  hi VertSplit guibg=#1a2027 guifg=#1a2027
  hi StatusLine guibg=#1a2027
  hi StatusLineNC guibg=#1a2027
  hi StatusLineTerm guibg=#1a2027
  hi StatusLineTermNC guibg=#1a2027
  hi NerdTree guibg=#1c242c
endfunction

silent! colorscheme hilal
