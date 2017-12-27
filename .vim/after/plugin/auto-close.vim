"----------------------------------------------------------------------"
" auto-close.vim                                                       "
" Copyright (c) 2016 Osman Koçak <kocakosm@gmail.com>                  "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists("g:loaded_auto_close")
  finish
endif
let g:loaded_auto_close = 1

let s:save_cpo = &cpo
set cpo&vim

if has("autocmd")
  function! s:auto_close()
    for i in range(1, winnr('$'))
      if getbufvar(winbufnr(i), '&modifiable') | return | endif
    endfor
    for _ in range(winnr('$')) | q | endfor
  endfunction
  augroup AutoClose
    autocmd!
    autocmd WinEnter * call <sid>auto_close()
  augroup END
endif

let &cpo = s:save_cpo
unlet s:save_cpo
