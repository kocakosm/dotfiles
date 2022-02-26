function! s:hilal() abort
  hi VertSplit guibg=#1a2027 guifg=#1a2027
  hi StatusLine guibg=#1a2027
  hi StatusLineNC guibg=#1a2027
  hi StatusLineTerm guibg=#1a2027
  hi StatusLineTermNC guibg=#1a2027
  hi NerdTree guibg=#1c242c
endfunction

augroup Colorscheme
  autocmd!
  autocmd ColorScheme hilal call <sid>hilal()
  if exists('+wincolor')
    autocmd BufWinEnter NERD_tree_1 ++once set wincolor=NerdTree
  endif
augroup END

silent! colorscheme hilal
