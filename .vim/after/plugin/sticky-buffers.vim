scriptencoding utf-8
"----------------------------------------------------------------------"
" sticky-buffers.vim                                                   "
" Copyright (c) 2018-2019 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_sticky_buffers')
  finish
endif
let g:loaded_sticky_buffers = 1

let s:save_cpo = &cpo
set cpo&vim

if !(has('autocmd') && exists('##BufWinEnter')
      \ && exists('##BufEnter') && exists('##FileType'))
  call s:warn('Missing required features/options')
  call s:on_exit()
  finish
endif

function! s:warn(msg) abort
  echohl WarningMsg | echomsg '[sticky-buffers]' a:msg | echohl None
endfunction

function! s:on_exit() abort
  let &cpo = s:save_cpo
  unlet s:save_cpo
endfunction

if !exists('g:sticky_buffers_exclude_filetypes')
  let g:sticky_buffers_exclude_filetypes = []
endif

let s:sticky_buffers = {}

function! s:on_buf_win_enter() abort
  let win = win_getid()
  if has_key(s:sticky_buffers, win)
    let buf = s:sticky_buffers[win]
    if buf !=# winbufnr(win)
      call feedkeys(":silent! b" . buf . " | echo ''\<cr>")
    endif
  endif
endfunction

function! s:update_sticky_buffers() abort
  call filter(s:sticky_buffers, 'win_id2win(v:key) !=# 0')
  for [win, buf] in items(s:sticky_buffers)
    if !s:is_sticky(buf) | call remove(s:sticky_buffers, win) | endif
  endfor
  let win = win_getid()
  if !has_key(s:sticky_buffers, win)
    let buf = winbufnr(win)
    if s:is_sticky(buf) | let s:sticky_buffers[win] = buf | endif
  endif
endfunction

function! s:is_sticky(buf) abort
  return bufexists(a:buf)
        \ && !s:is_excluded(getbufvar(a:buf, '&filetype'))
        \ && (getbufvar(a:buf, '&buftype') !=# '' || !buflisted(a:buf))
endfunction

function! s:is_excluded(ft) abort
  return index(g:sticky_buffers_exclude_filetypes, a:ft) !=# -1
endfunction

augroup StickyBuffers
  autocmd!
  autocmd BufWinEnter * call <sid>on_buf_win_enter()
  autocmd Filetype,BufEnter * call <sid>update_sticky_buffers()
augroup END

call s:on_exit()
