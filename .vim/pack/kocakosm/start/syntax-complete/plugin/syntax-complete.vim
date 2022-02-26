scriptencoding utf-8
"----------------------------------------------------------------------"
" syntax-complete.vim                                                  "
" Copyright (c) 2017-2022 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_syntax_complete') || v:version < 704 || &cp
  finish
endif
let g:loaded_syntax_complete = 1

let s:cpo = &cpo
set cpo&vim

augroup SyntaxComplete
  autocmd!
  autocmd FileType *
        \ if &omnifunc ==# '' |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup END

let &cpo = s:cpo
unlet! s:cpo
