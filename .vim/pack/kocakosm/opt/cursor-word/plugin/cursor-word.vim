scriptencoding utf-8
"----------------------------------------------------------------------"
" cursor-word.vim                                                      "
" Copyright (c) Osman Koçak <kocakosm@gmail.com>                       "
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

augroup __CursorWord__ | augroup END

function! s:enable_plugin() abort
  autocmd! __CursorWord__
  autocmd __CursorWord__ CursorHold * call <sid>match_cword()
  autocmd __CursorWord__ CursorHoldI * call <sid>match_cword()
endfunction

function! s:disable_plugin() abort
  autocmd! __CursorWord__
  call s:clear_matches()
endfunction

if get(g:, 'cursor_word_enabled', 1)
  call s:enable_plugin()
endif

command! -bar CursorWordOn call <sid>enable_plugin()
command! -bar CursorWordOff call <sid>disable_plugin()

let &cpo = s:cpo
unlet! s:cpo
