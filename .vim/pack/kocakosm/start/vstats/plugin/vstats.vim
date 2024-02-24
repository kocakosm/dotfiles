scriptencoding utf-8
"----------------------------------------------------------------------"
" vstats.vim                                                           "
" Copyright (c) 2018-2022 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_vstats') || v:version < 704 || &cp
  finish
endif
let g:loaded_vstats = 1

let s:cpo = &cpo
set cpo&vim

let s:temporary_register = 'a'
let s:number_pattern = '^[+-]\?\d\+\%([.]\d\+\)\?\([eE][+-]\?\d\+\)\?$'

function! s:get_last_visual_selection() abort
  let register_content = getreg(s:temporary_register)
  let register_type = getregtype(s:temporary_register)
  try
    execute 'silent! normal! gv"' . s:temporary_register . 'ygv'
    return getreg(s:temporary_register)
  finally
    call setreg(s:temporary_register, register_content, register_type)
  endtry
endfunction

function! s:extract_numbers(string) abort
  let tokens = split(a:string)
  return map(filter(tokens, 'v:val =~ s:number_pattern'), 'str2float(v:val)')
endfunction

function! s:warn(msg) abort
  echohl WarningMsg | echomsg '[vstats]' a:msg | echohl None
endfunction

function! s:sum(numbers) abort
  let sum = 0
  for n in a:numbers
    let sum += n
  endfor
  return sum
endfunction

function! s:max(numbers) abort
  let max = a:numbers[0]
  for n in a:numbers[1:]
    if n > max | let max = n | endif
  endfor
  return max
endfunction

function! s:str(number) abort
  let s = printf('%.10g', a:number)
  let i = match(s, '\.\?0\+$')
  return i < 0 ? s : strpart(s, 0, i)
endfunction

function! s:print_stats() abort
  let numbers = sort(s:extract_numbers(s:get_last_visual_selection()), 'f')
  if len(numbers)
    let sum = s:sum(numbers)
    let avg = 1.0 * sum / len(numbers)
    let min = numbers[0]
    let max = numbers[-1]
    let med = numbers[s:max([len(numbers) / 2, (len(numbers) + 1) / 2]) - 1]
    let separator = get(g:, 'vstats_separator', '    ')
    echo 'sum: ' . s:str(sum) . separator
    echon 'avg: ' . s:str(avg) . separator
    echon 'med: ' . s:str(med) . separator
    echon 'min: ' . s:str(min) . separator
    echon 'max: ' . s:str(max)
  else
    call s:warn('No numbers could be extracted from this visual selection')
  endif
endfunction

noremap <silent> <script> <plug>(vstats) :<c-u>call <sid>print_stats()<cr>

let &cpo = s:cpo
unlet! s:cpo
