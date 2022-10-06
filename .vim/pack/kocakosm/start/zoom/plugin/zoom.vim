scriptencoding utf-8
"----------------------------------------------------------------------"
" zoom.vim                                                             "
" Copyright (c) 2020-2022 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_zoom') || v:version < 802 || &cp
  finish
endif
let g:loaded_zoom = 1

noremap <silent> <script> <plug>(zoom#toggle) :<c-u>call zoom#toggle()<cr>
