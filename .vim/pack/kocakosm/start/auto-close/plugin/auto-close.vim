scriptencoding utf-8
"----------------------------------------------------------------------"
" auto-close.vim                                                       "
" Copyright (c) 2016-2022 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_auto_close') || v:version < 704 || &cp
  finish
endif
let g:loaded_auto_close = 1

let s:cpo = &cpo
set cpo&vim

function! s:on_quit_pre() abort
  let winnr = winnr('$')
  let non_ordinary = filter(range(winnr, 1, -1), '!s:is_ordinary(winbufnr(v:val))')
  if s:is_ordinary(bufnr('%')) && len(non_ordinary) == winnr - 1
    call s:close_windows(non_ordinary)
  elseif len(non_ordinary) == winnr
    call s:close_windows(filter(non_ordinary, 'v:val != ' . winnr()))
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

augroup __AutoClose__
  autocmd!
  autocmd QuitPre * call <sid>on_quit_pre()
augroup END

let &cpo = s:cpo
unlet! s:cpo
