scriptencoding utf-8

let g:nuake_position='top'
let g:nuake_size=0.33
let g:nuake_per_tab=0

function! s:toggle_nuake() abort
  StickyBuffersOff
  Nuake
  StickyBuffersOn
endfunction

nnoremap <silent> <f4> :call <sid>toggle_nuake()<cr>
inoremap <silent> <f4> <c-\><c-n>:call <sid>toggle_nuake()<cr>
tnoremap <silent> <f4> <c-\><c-n>:call <sid>toggle_nuake()<cr>
