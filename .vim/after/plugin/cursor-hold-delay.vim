scriptencoding utf-8
"----------------------------------------------------------------------"
" cursor-hold-delay.vim                                                "
" Decouples CursorHold and CursorHoldI autocmd events from updatetime  "
" Based on https://github.com/antoinemadec/FixCursorHold.nvim          "
" All credit goes to Antoine Madec                                     "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_cursor_hold_delay') || v:version <# 800 || &cp
  finish
endif
let g:loaded_cursor_hold_delay = 1

let s:cpo = &cpo
set cpo&vim

let s:timer = -1
set eventignore+=CursorHold,CursorHoldI

function! s:get_cursor_hold_delay() abort
  return get(g:, 'cursor_hold_delay', &updatetime)
endfunction

function! s:fire_cursor_hold(timer_id) abort
  set eventignore-=CursorHold
  doautocmd CursorHold
  set eventignore+=CursorHold
endfunction

function! s:fire_cursor_hold_i(timer_id) abort
  set eventignore-=CursorHoldI
  doautocmd CursorHoldI
  set eventignore+=CursorHoldI
endfunction

function! s:on_cursor_moved() abort
  call timer_stop(s:timer)
  if mode() ==# 'n'
    let delay = s:get_cursor_hold_delay()
    let s:timer = timer_start(delay, funcref('s:fire_cursor_hold'))
  endif
endfunction

function! s:on_cursor_moved_i() abort
  call timer_stop(s:timer)
  let delay = s:get_cursor_hold_delay()
  let s:timer = timer_start(delay, funcref('s:fire_cursor_hold_i'))
endfunction

augroup CursorHoldDelay
  autocmd!
  autocmd CursorMoved * call <sid>on_cursor_moved()
  autocmd CursorMovedI * call <sid>on_cursor_moved_i()
augroup END

let &cpo = s:cpo
unlet! s:cpo
