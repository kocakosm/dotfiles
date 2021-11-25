scriptencoding utf-8

let g:NERDTreeMinimalUI=1
let g:NERDTreeMouseMode=3
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeHijackNetrw=0
let g:NERDTreeWinSize=40
let g:NERDTreeStatusline=''

function! s:toggle_nerd_tree() abort
  StickyBuffersOff
  NERDTreeToggle
  StickyBuffersOn
endfunction

nnoremap <silent> <f5> :call <sid>toggle_nerd_tree()<cr>
