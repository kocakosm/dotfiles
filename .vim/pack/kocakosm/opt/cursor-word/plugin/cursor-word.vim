scriptencoding utf-8
"----------------------------------------------------------------------"
" cursor-word.vim                                                      "
" Copyright (c) 2017-2022 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_cursor_word') || v:version < 704 || &cp
  finish
endif
let g:loaded_cursor_word = 1

let s:cpo = &cpo
set cpo&vim

highlight default CursorWord gui=BOLD cterm=BOLD

function! s:clear_matches() abort
  for m in getmatches()
    if m.group ==# 'CursorWord' | call matchdelete(m.id) | endif
  endfor
endfunction

function! s:match_cword() abort
  call s:clear_matches()
  let cword = expand('<cword>')
  call matchadd('CursorWord', '\V\<' . escape(cword, '\') . '\>', -10)
endfunction

function! s:enable_plugin() abort
  augroup CursorWord
    autocmd!
    autocmd CursorHold * call <sid>match_cword()
    autocmd CursorHoldI * call <sid>match_cword()
  augroup END
endfunction

function! s:disable_plugin() abort
  augroup CursorWord
    autocmd!
  augroup END
  call s:clear_matches()
endfunction

if get(g:, 'cursor_word_enabled', 1)
  call s:enable_plugin()
endif

command! -bar CursorWordOn call <sid>enable_plugin()
command! -bar CursorWordOff call <sid>disable_plugin()

let &cpo = s:cpo
unlet! s:cpo
