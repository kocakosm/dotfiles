scriptencoding utf-8
"----------------------------------------------------------------------"
" grepm.vim                                                            "
" All credit goes to Romain Lafourcade (romainl)                       "
" This plugin is based on his wonderful 'Instant grep + quickfix' gist "
" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3     "
" Copyright (c) 2020-2021 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_grepm') || (v:version <# 802 && !has('nvim-0.5')) || &cp
  finish
endif
let g:loaded_grepm = 1

let s:cpo = &cpo
set cpo&vim

let s:has_result = 0

function! s:grep(...) abort
  let cmd = join([&grepprg] + [expandcmd(join(a:000, ' '))], ' ')
  let result = system(cmd)
  let s:has_result = !empty(result)
  if !s:has_result
    call s:warn('No result for "' . cmd . '"')
  endif
  return result
endfunction

function! s:on_grep() abort
  call setqflist([], 'a', {'title': ''})
  cwindow | doautocmd BufWinEnter
endfunction

function! s:on_lgrep() abort
  call setloclist(0, [], 'a', {'title': ''})
  lwindow | doautocmd BufWinEnter
endfunction

function! s:on_grepadd() abort
  if s:has_result | call s:on_grep() | endif
endfunction

function! s:on_lgrepadd() abort
  if s:has_result | call s:on_lgrep() | endif
endfunction

function! s:warn(msg) abort
  echohl WarningMsg | echomsg '[grepm]' a:msg | echohl None
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr <sid>grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar Grepadd caddexpr <sid>grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr <sid>grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrepadd laddexpr <sid>grep(<f-args>)

cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep'
cnoreabbrev <expr> grepa (getcmdtype() ==# ':' && getcmdline() ==# 'grepa') ? 'Grepa' : 'grepa'
cnoreabbrev <expr> grepad (getcmdtype() ==# ':' && getcmdline() ==# 'grepad') ? 'Grepad' : 'grepad'
cnoreabbrev <expr> grepadd (getcmdtype() ==# ':' && getcmdline() ==# 'grepadd') ? 'Grepadd' : 'grepadd'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'
cnoreabbrev <expr> lgrepa (getcmdtype() ==# ':' && getcmdline() ==# 'lgrepa') ? 'LGrepa' : 'lgrepa'
cnoreabbrev <expr> lgrepad (getcmdtype() ==# ':' && getcmdline() ==# 'lgrepad') ? 'LGrepad' : 'lgrepad'
cnoreabbrev <expr> lgrepadd (getcmdtype() ==# ':' && getcmdline() ==# 'lgrepadd') ? 'LGrepadd' : 'lgrepadd'

augroup Grepm
  autocmd!
  autocmd QuickFixCmdPost cgetexpr call <sid>on_grep()
  autocmd QuickFixCmdPost caddexpr call <sid>on_grepadd()
  autocmd QuickFixCmdPost lgetexpr call <sid>on_lgrep()
  autocmd QuickFixCmdPost laddexpr call <sid>on_lgrepadd()
augroup END

let &cpo = s:cpo
unlet! s:cpo
