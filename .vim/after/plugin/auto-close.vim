"----------------------------------------------------------------------"
" auto-close.vim                                                       "
" Copyright (c) 2016-2018 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_auto_close')
  finish
endif
let g:loaded_auto_close = 1

let s:save_cpo = &cpo
set cpo&vim

if !(has('autocmd') && exists('##QuitPre'))
  call s:warn('Missing required features/options')
  finish
endif

function! s:warn(msg) abort
  echohl WarningMsg | echomsg '[auto-close]' a:msg | echohl None
endfunction

function! s:on_quit_pre() abort
  if buflisted(winbufnr(winnr()))
    let winnr = winnr('$')
    let unlisted = filter(range(winnr, 1, -1), '!buflisted(winbufnr(v:val))')
    if winnr - len(unlisted) == 1
      for i in unlisted
        execute i . 'wincmd w' | silent! quit
      endfor
    endif
  endif
endfunction

augroup AutoClose
  autocmd!
  autocmd QuitPre * call <sid>on_quit_pre()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
