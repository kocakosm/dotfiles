"----------------------------------------------------------------------"
" vstats.vim                                                           "
" This is a heavily modified version of Damian Conway's vmath plugin.  "
" This file is placed under the public domain.                         "
"----------------------------------------------------------------------"

if exists('g:loaded_vstats')
  finish
endif
let g:loaded_vstats = 1

let s:save_cpo = &cpo
set cpo&vim

let s:report_gap = 4
let s:number_pattern = '^[+-]\?\d\+\%([.]\d\+\)\?\([eE][+-]\?\d\+\)\?$'

function! s:get_visual_selection() abort
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction

function! s:sum(numbers) abort
  let sum = 0
  for n in a:numbers
    let sum = sum + n
  endfor
  return sum
endfunction

function! s:min(numbers) abort
  if !len(a:numbers)
    return 0
  endif
  let numbers = copy(a:numbers)
  let min = numbers[0]
  for n in numbers[1:]
    if n < min
      let min = n
    endif
  endfor
  return min
endfunction

function! s:max(numbers) abort
  if !len(a:numbers)
    return 0
  endif
  let numbers = copy(a:numbers)
  let max = numbers[0]
  for n in numbers[1:]
    if n > max
      let max = n
    endif
  endfor
  return max
endfunction

function! s:str(number) abort
  return printf('%g', a:number)
endfunction

function! s:show_stats() abort
  let selection = s:get_visual_selection()
  let numbers = map(filter(split(selection), 'v:val =~ s:number_pattern'), 'str2float(v:val)')
  let sum = s:sum(numbers)
  let avg = 1.0 * sum / max([len(numbers), 1])
  let min = s:min(numbers)
  let max = s:max(numbers)
  let gap = repeat(' ', s:report_gap)
  echo 'sum: ' . s:str(sum) . gap
  echon 'avg: ' . s:str(avg) . gap
  echon 'min: ' . s:str(min) . gap
  echon 'max: ' . s:str(max)
endfunction

let &cpo = s:save_cpo

command! -range VStats call <sid>show_stats()
