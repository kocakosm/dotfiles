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
  highlight SpecialKey guifg=#1f242d
endfunction

function! s:sorbet() abort
  highlight NerdTree guibg=#1b1d2a
  highlight SignifySignAdd guifg=#00af5f guibg=NONE gui=NONE cterm=NONE
  highlight SignifySignChange guifg=#87afff guibg=NONE gui=NONE cterm=NONE
  highlight SignifySignDelete guifg=#d7005f guibg=NONE gui=NONE cterm=NONE
  highlight StatusLine guifg=#161821 guibg=#8787af gui=NONE cterm=NONE
  highlight StatusLineNC guifg=#47476f guibg=#8787af gui=NONE cterm=NONE
  highlight SpecialKey guifg=#2f283f gui=NONE
  highlight CursorLine guibg=#242438
  highlight CursorLineNr guibg=NONE
  highlight ColorColumn guifg=NONE guibg=#242438 gui=NONE cterm=NONE
  highlight Identifier guifg=#5fafaf
  highlight String guifg=#af87d7
  highlight Comment guifg=#3f4f5a
  highlight JavaDocComment guifg=#3f4f5a guibg=NONE gui=ITALIC
  highlight JavaAnnotation guifg=#7a8a8f guibg=NONE gui=NONE
  highlight JavaParen guifg=#9fafba guibg=NONE gui=NONE
  highlight link JavaCommentTitle JavaDocComment
  highlight link JavaDocTags JavaDocComment
  highlight link JavaDocParam JavaDocTags
  highlight link JavaDocSeeTagParam JavaDocTags
  highlight link JavaDocSeeTag JavaDocTags
  highlight link JavaParen1 JavaParen
endfunction

function! s:iceberg() abort
  call async#execute('set background=dark')
  highlight LineNr guibg=NONE
  highlight CursorLineNr guibg=NONE gui=NONE
  highlight SignColumn guibg=NONE
  highlight GitGutterAdd guibg=NONE guifg=#b4be82
  highlight GitGutterChange guibg=NONE guifg=#89b8c2
  highlight GitGutterChangeDelete guibg=NONE guifg=#89b8c2
  highlight GitGutterDelete guibg=NONE guifg=#e27878
  highlight StatusLine guibg=#0d0f15 guifg=#6f738d gui=NONE
  highlight link SkylineNC StatusLineNC
  highlight Skyline guibg=#818596 guifg=#17171b
  highlight MoreMsg gui=NONE
  highlight link JavaScopeDecl Identifier
  highlight link JavaCommentTitle JavaDocComment
  highlight link JavaDocTags JavaDocComment
  highlight link JavaDocParam JavaDocTags
  highlight link JavaDocSeeTagParam JavaDocTags
  highlight link JavaDocSeeTag JavaDocTags
  highlight link JavaParen1 JavaParen
endfunction

silent! colorscheme hilal
