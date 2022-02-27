scriptencoding utf-8
"----------------------------------------------------------------------"
" skyline.vim                                                          "
" Copyright (c) 2022 Osman Koçak <kocakosm@gmail.com>                  "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_skyline') || (v:version < 802 && !has('nvim-0.6')) || &cp
  finish
endif
let g:loaded_skyline = 1

let s:cpo = &cpo
set cpo&vim

let g:qf_disable_statusline = 1

if exists('g:colors_name')
  call skyline#set_theme(g:colors_name)
endif

augroup Skyline
  autocmd!
  autocmd ColorScheme * call skyline#set_theme(expand('<amatch>'))
augroup END

let &cpo = s:cpo
unlet! s:cpo
