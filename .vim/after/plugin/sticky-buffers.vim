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

if !(has('autocmd') && exists('##BufWinEnter') && exists('##FileType'))
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

let s:sticky_buffers = {}
let s:ignored_file_types = ['help', 'netrw']

function! s:on_buf_win_enter() abort
  call filter(s:sticky_buffers, 'win_id2win(v:key) !=# 0')
  let buf_nr = bufnr()
  let win_id = win_getid()
  if has_key(s:sticky_buffers, win_id)
    call feedkeys(":silent! b" . s:sticky_buffers[win_id] . " | echo ''\<cr>")
  elseif getbufvar(buf_nr, '&buftype') !=# '' || !buflisted(buf_nr)
    let s:sticky_buffers[win_id] = buf_nr
  endif
endfunction

function! s:on_file_type() abort
  for [win, buf] in items(s:sticky_buffers)
    if index(s:ignored_file_types, getbufvar(buf, '&filetype')) > -1
      call remove(s:sticky_buffers, win)
    endif
  endfor
endfunction

augroup StickyBuffers
  autocmd!
  autocmd FileType * call <sid>on_file_type()
  autocmd BufWinEnter * call <sid>on_buf_win_enter()
  autocmd User NERDTreeInit ++once call <sid>on_buf_win_enter()
augroup END

call s:on_exit()
