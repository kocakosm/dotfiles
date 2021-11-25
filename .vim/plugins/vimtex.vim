scriptencoding utf-8

let g:tex_flavor='latex'
let g:vimtex_enabled=1
let g:vimtex_view_method='mupdf'
let g:vimtex_quickfix_mode=0

augroup Vimtex
  autocmd!
  autocmd User VimtexEventQuit call vimtex#compiler#clean(0)
  autocmd User VimtexEventInitPost call vimtex#compiler#compile()
augroup END
