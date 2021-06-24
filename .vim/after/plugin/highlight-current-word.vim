scriptencoding utf-8
"----------------------------------------------------------------------"
" highlight-current-word.vim                                           "
" Copyright (c) 2017-2021 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_highlight_current_word') || v:version <# 704 || &cp
  finish
endif
let g:loaded_highlight_current_word = 1

let s:cpo = &cpo
set cpo&vim

if !hlexists('CurrentWord')
  highlight CurrentWord gui=BOLD cterm=BOLD
endif

function! s:clear_matches() abort
  for m in getmatches()
    if m.group ==# 'CurrentWord' | call matchdelete(m.id) | endif
  endfor
endfunction

function! s:match_current_word() abort
  call s:clear_matches()
  let cword = expand('<cword>')
  call matchadd('CurrentWord', '\V\<' . escape(cword, '\') . '\>', -10)
endfunction

function! s:enable_plugin() abort
  augroup HighlightCurrentWord
    autocmd!
    autocmd CursorHold * call <sid>match_current_word()
    autocmd CursorHoldI * call <sid>match_current_word()
  augroup END
endfunction

function! s:disable_plugin() abort
  augroup HighlightCurrentWord
    autocmd!
  augroup END
  call s:clear_matches()
endfunction

if get(g:, 'highlight_current_word_enabled', 0) !=# 0
 call s:enable_plugin()
endif

command! HighlightCurrentWordEnable call <sid>enable_plugin()
command! HighlightCurrentWordDisable call <sid>disable_plugin()

let &cpo = s:cpo
unlet! s:cpo
