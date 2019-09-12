"----------------------------------------------------------------------"
" auto-close.vim                                                       "
" Copyright (c) 2016-2019 Osman Koçak <kocakosm@gmail.com>             "
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
  call s:on_exit()
  finish
endif

function! s:warn(msg) abort
  echohl WarningMsg | echomsg '[auto-close]' a:msg | echohl None
endfunction

function! s:on_exit() abort
  let &cpo = s:save_cpo
  unlet s:save_cpo
endfunction

function! s:on_quit_pre() abort
  let winnr = winnr('$')
  let non_ordinary = filter(range(winnr, 1, -1), '!s:is_ordinary(winbufnr(v:val))')
  if s:is_ordinary(bufnr('%')) && len(non_ordinary) ==# winnr - 1
    call s:close_windows(non_ordinary)
  elseif len(non_ordinary) ==# winnr
    call s:close_windows(filter(non_ordinary, 'v:val !=# ' . winnr()))
  endif
endfunction

function! s:is_ordinary(bufnr) abort
  return buflisted(a:bufnr) && getbufvar(a:bufnr, '&buftype') ==# ''
endfunction

function! s:close_windows(windows) abort
  for i in a:windows
    execute i . 'wincmd w' | silent! quit
  endfor
endfunction

augroup AutoClose
  autocmd!
  autocmd QuitPre * call <sid>on_quit_pre()
augroup END

call s:on_exit()
