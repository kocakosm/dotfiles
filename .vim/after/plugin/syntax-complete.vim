"----------------------------------------------------------------------"
" syntax-complete.vim                                                  "
" Copyright (c) 2017 Osman Koçak <kocakosm@gmail.com>                  "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists("g:loaded_syntax_complete")
  finish
endif
let g:loaded_syntax_complete = 1

let s:save_cpo = &cpo
set cpo&vim

if has("autocmd") && exists("+omnifunc")
  augroup SyntaxComplete
    autocmd!
    autocmd FileType *
          \ if &omnifunc == '' |
          \   setlocal omnifunc=syntaxcomplete#Complete |
          \ endif
  augroup END
endif

let &cpo = s:save_cpo
unlet s:save_cpo
