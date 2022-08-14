scriptencoding utf-8
"----------------------------------------------------------------------"
" popterm.vim                                                          "
" Copyright (c) 2022 Osman Koçak <kocakosm@gmail.com>                  "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_popterm') || v:version < 900 || &cp
  finish
endif
let g:loaded_popterm = 1

command! -bar PopTermToggle call popterm#toggle()
