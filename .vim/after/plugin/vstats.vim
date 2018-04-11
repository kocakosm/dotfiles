"----------------------------------------------------------------------"
" vstats.vim                                                           "
" This is a _heavily_ modified version of Damian Conway's vmath plugin."
" This file is placed under the public domain.                         "
"----------------------------------------------------------------------"

if exists('g:loaded_vstats')
  finish
endif
let g:loaded_vstats = 1

let s:save_cpo = &cpo
set cpo&vim

let s:report_gap = 4
let s:temporary_register = 'a'
let s:number_pattern = '^[+-]\?\d\+\%([.]\d\+\)\?\([eE][+-]\?\d\+\)\?$'

function! s:get_last_visual_selection() abort
  let register_content = getreg(s:temporary_register)
  let register_type = getregtype(s:temporary_register)
  execute 'silent! normal! gv"' . s:temporary_register . 'ygv'
  let selection = getreg(s:temporary_register)
  call setreg(s:temporary_register, register_content, register_type)
  return selection
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

function! s:min(numbers) abort
  let min = a:numbers[0]
  for n in a:numbers[1:]
    if n < min | let min = n | endif
  endfor
  return min
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
  if i >= 0 | let s = strpart(s, 0, i) | endif
  return s
endfunction

function! s:print_stats() abort
  let numbers = s:extract_numbers(s:get_last_visual_selection())
  if len(numbers)
    let sum = s:sum(numbers)
    let avg = 1.0 * sum / max([len(numbers), 1])
    let min = s:min(numbers)
    let max = s:max(numbers)
    let gap = repeat(' ', s:report_gap)
    echo 'sum: ' . s:str(sum) . gap
    echon 'avg: ' . s:str(avg) . gap
    echon 'min: ' . s:str(min) . gap
    echon 'max: ' . s:str(max)
  else
    call s:warn('No numbers could be extracted from this visual selection')
  endif
endfunction

noremap <silent> <script> <plug>(vstats) :<c-u>call <sid>print_stats()<cr>

let &cpo = s:save_cpo
