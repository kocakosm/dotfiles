scriptencoding utf-8
"----------------------------------------------------------------------"
" sticky-buffers.vim                                                   "
" Copyright (c) 2018-2022 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_sticky_buffers') || v:version < 800 || &cp
  finish
endif
let g:loaded_sticky_buffers = 1

let s:cpo = &cpo
set cpo&vim

let s:sticky_buffers = {}
let s:transient_windows = []

function! s:on_win_new() abort
  call add(s:transient_windows, win_getid())
endfunction

function! s:on_buf_win_enter() abort
  call filter(s:transient_windows, 'v:val != ' . win_getid())
endfunction

function! s:on_buf_enter() abort
  let win = win_getid()
  if !s:contains(s:transient_windows, win) && has_key(s:sticky_buffers, win)
    let buf = s:sticky_buffers[win]
    if buf != winbufnr(win)
      execute 'silent! buffer ' . buf
    endif
  endif
endfunction

function! s:on_buf_leave() abort
  call filter(s:sticky_buffers, 'win_id2win(v:key) != 0')
  let win = win_getid()
  if !s:contains(s:transient_windows, win) && !has_key(s:sticky_buffers, win)
    let buf = winbufnr(win)
    if s:is_sticky(buf) | let s:sticky_buffers[win] = buf | endif
  endif
endfunction

function! s:is_sticky(buf) abort
  let buftype = getbufvar(a:buf, '&buftype')
  let ignored_buftypes = get(g:, 'sticky_buffers_ignored_buftypes', [])
  let ignored_filetypes = get(g:, 'sticky_buffers_ignored_filetypes', [])
  return bufexists(a:buf)
        \ && (buftype !=# '' || !buflisted(a:buf))
        \ && !s:contains(ignored_buftypes, buftype)
        \ && !s:contains(ignored_filetypes, getbufvar(a:buf, '&filetype'))
endfunction

function! s:contains(list, element) abort
  return index(a:list, a:element) >= 0
endfunction

function! s:enable_plugin() abort
  augroup StickyBuffers
    autocmd!
    autocmd WinNew * call <sid>on_win_new()
    autocmd BufWinEnter * call <sid>on_buf_win_enter()
    autocmd BufEnter * call <sid>on_buf_enter()
    autocmd BufLeave * call <sid>on_buf_leave()
  augroup END
endfunction

function! s:disable_plugin() abort
  augroup StickyBuffers
    autocmd!
  augroup END
endfunction

if get(g:, 'sticky_buffers_enabled', 1)
  call s:enable_plugin()
endif

command! -bar StickyBuffersOn call <sid>enable_plugin()
command! -bar StickyBuffersOff call <sid>disable_plugin()

let &cpo = s:cpo
unlet! s:cpo
