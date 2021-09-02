scriptencoding utf-8
"----------------------------------------------------------------------"
" sticky-buffers.vim                                                   "
" Copyright (c) 2018-2021 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_sticky_buffers') || v:version <# 800 || &cp
  finish
endif
let g:loaded_sticky_buffers = 1

let s:cpo = &cpo
set cpo&vim

let s:sticky_buffers = {}

function! s:on_buf_enter() abort
  let win = win_getid()
  if has_key(s:sticky_buffers, win)
    let buf = s:sticky_buffers[win]
    if buf !=# winbufnr(win)
      execute "silent! buffer " . buf
    endif
  endif
endfunction

function! s:on_buf_leave() abort
  call filter(s:sticky_buffers, 'win_id2win(v:key) !=# 0')
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
  return index(get(g:, 'sticky_buffers_exclude_filetypes', []), a:ft) !=# -1
endfunction

function! s:enable_plugin() abort
  augroup StickyBuffers
    autocmd!
    autocmd BufEnter * call <sid>on_buf_enter()
    autocmd BufLeave * call <sid>on_buf_leave()
  augroup END
endfunction

function! s:disable_plugin() abort
  augroup StickyBuffers
    autocmd!
  augroup END
endfunction

if get(g:, 'sticky_buffers_enabled', 1) !=# 0
 call s:enable_plugin()
endif

command! StickyBuffersEnable call <sid>enable_plugin()
command! StickyBuffersDisable call <sid>disable_plugin()

let &cpo = s:cpo
unlet! s:cpo
