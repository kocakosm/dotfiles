"----------------------------------------------------------------------"
" highlight-current-word.vim                                           "
" Copyright (c) 2017-2018 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_highlight_current_word')
  finish
endif
let g:loaded_highlight_current_word = 1

let s:save_cpo = &cpo
set cpo&vim

if !(has('autocmd') && exists('+syntax')
      \ && exists('##CursorHold') && exists('##CursorHoldI'))
  call s:warn('Missing required features/options')
  call s:on_exit()
  finish
endif

function! s:warn(msg) abort
  echohl WarningMsg | echomsg '[highlight-current-word]' a:msg | echohl None
endfunction

function! s:on_exit() abort
  let &cpo = s:save_cpo
  unlet s:save_cpo
endfunction

if !hlexists('CurrentWord')
  highlight CurrentWord gui=BOLD cterm=BOLD
endif

function! s:match_current_word() abort
  for m in getmatches()
    if m.group == 'CurrentWord' | call matchdelete(m.id) | endif
  endfor
  let cword = expand('<cword>')
  call matchadd('CurrentWord', '\V\<' . escape(cword, '\') . '\>', -10)
endfunction

augroup HighlightCurrentWord
  autocmd!
  autocmd CursorHold * call <sid>match_current_word()
  autocmd CursorHoldI * call <sid>match_current_word()
augroup END

call s:on_exit()
