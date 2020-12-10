scriptencoding utf-8
"----------------------------------------------------------------------"
" quickfix-format.vim                                                  "
" Copyright (c) 2020 Osman Koçak <kocakosm@gmail.com>                  "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_quickfix_format') || v:version <# 800 || &cp
  finish
endif
let g:loaded_quickfix_format = 1

let s:cpo = &cpo
set cpo&vim

function! s:quickfix_format() abort
  setlocal modifiable
  let items = s:is_location_list() ? getloclist(0) : getqflist()
  call setline('1', s:reformat_items(items))
  setlocal nomodifiable nomodified
endfunction

function! s:is_location_list() abort
  return getwininfo(win_getid())[0]['loclist']
endfunction

function! s:reformat_items(items) abort
  let max_location_len = 0
  for item in a:items
    if item.bufnr ># 0
      let location = bufname(item.bufnr) . ':' . item.lnum
      let location_len = strchars(location)
      if location_len ># max_location_len
        let max_location_len = location_len
      endif
      call extend(item, {'location': location})
    else
      call extend(item, {'location': ''})
    endif
  endfor
  let fmt = '%-' . max_location_len . 's' . '%s'
  return map(a:items, 'printf(fmt, v:val.location, " " . trim(v:val.text))')
endfunction

augroup QuickFixFormat
  autocmd!
  autocmd BufReadPost quickfix call <sid>quickfix_format()
augroup END

let &cpo = s:cpo
unlet! s:cpo
