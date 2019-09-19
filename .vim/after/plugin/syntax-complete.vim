scriptencoding utf-8
"----------------------------------------------------------------------"
" syntax-complete.vim                                                  "
" Copyright (c) 2017-2019 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_syntax_complete')
  finish
endif
let g:loaded_syntax_complete = 1

let s:save_cpo = &cpo
set cpo&vim

if !(has('autocmd') && exists('+omnifunc') && exists('##FileType'))
  call s:warn('Missing required features/options')
  call s:on_exit()
  finish
endif

function! s:warn(msg) abort
  echohl WarningMsg | echomsg '[syntax-complete]' a:msg | echohl None
endfunction

function! s:on_exit() abort
  let &cpo = s:save_cpo
  unlet s:save_cpo
endfunction

augroup SyntaxComplete
  autocmd!
  autocmd FileType *
        \ if &omnifunc ==# '' |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup END

call s:on_exit()
