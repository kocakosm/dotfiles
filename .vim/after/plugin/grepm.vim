scriptencoding utf-8
"----------------------------------------------------------------------"
" grepm.vim                                                            "
" Inspired by romainl's wonderful 'Instant grep + quickfix' gist       "
" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3     "
" Copyright (c) 2020-2021 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_grepm') || v:version <# 802 || &cp
  finish
endif
let g:loaded_grepm = 1

let s:cpo = &cpo
set cpo&vim

let s:cmd = ''

function! s:grep(...) abort
  let s:cmd = join([&grepprg] + [expandcmd(join(a:000, ' '))], ' ')
  return system(s:cmd)
endfunction

function! s:on_grep() abort
  if empty(getqflist())
    cclose
    call s:warn('[grep] No result for "' . s:cmd . '"')
    doautocmd BufWinEnter
  else
    call setqflist([], 'a', {'title': s:cmd})
    copen
  endif
endfunction

function! s:on_lgrep() abort
  if empty(getloclist(0))
    lclose
    call s:warn('[lgrep] No result for "' . s:cmd . '"')
    doautocmd BufWinEnter
  else
    call setloclist(0, [], 'a', {'title': s:cmd})
    lopen
  endif
endfunction

function! s:warn(msg) abort
  echohl WarningMsg | echomsg a:msg | echohl None
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr <sid>grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr <sid>grep(<f-args>)

cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup Grepm
  autocmd!
  autocmd QuickFixCmdPost cgetexpr call <sid>on_grep()
  autocmd QuickFixCmdPost lgetexpr call <sid>on_lgrep()
augroup END

let &cpo = s:cpo
unlet! s:cpo
