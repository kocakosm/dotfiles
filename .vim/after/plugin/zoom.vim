scriptencoding utf-8
"----------------------------------------------------------------------"
" zoom.vim                                                             "
" Copyright (c) 2020-2021 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_zoom') || v:version <# 802 || &cp
  finish
endif
let g:loaded_zoom = 1

let s:cpo = &cpo
set cpo&vim

function! s:toggle_zoom() abort
  if s:is_zoomed()
    call s:zoom_out()
  else
    call s:zoom_in()
  endif
endfunction

function! s:zoom_in() abort
  if winnr('$') ># 1
    let t:zoom_zoomed_bufnr = winbufnr(winnr())
    let t:zoom_saved_view = s:get_current_view()
    call s:close_other_windows()
    let t:zoom_zoomed = v:true
  else
    call s:warn('Already only one window')
  endif
endfunction

function! s:zoom_out() abort
  if s:is_zoomed()
    call s:restore_view(t:zoom_saved_view)
    let t:zoom_zoomed = v:false
    unlet! t:zoom_saved_view t:zoom_zoomed_bufnr
  else
    call s:warn('Not zoomed')
  endif
endfunction

function! s:is_zoomed() abort
  return get(t:, "zoom_zoomed", v:false)
endfunction

function! s:close_other_windows() abort
  silent! wincmd o
endfunction

function! s:get_current_view() abort
  return #{
    \ win_layout: s:replace_winid_by_bufnr(winlayout()),
    \ win_resize_cmd: winrestcmd(),
    \ cursor: #{
      \ winnr: winnr(),
      \ position: getcurpos()
    \}
  \}
endfunction

function! s:replace_winid_by_bufnr(layout) abort
  let layout = deepcopy(a:layout)
  if layout[0] ==# 'leaf'
    let layout[1] = winbufnr(layout[1])
  else
    for i in range(len(layout[1]))
      let nested_layout = layout[1][i]
      let layout[1][i] = s:replace_winid_by_bufnr(nested_layout)
    endfor
  endif
  return layout
endfunction

function! s:restore_view(view) abort
  call s:close_other_windows()
  call s:restore_layout(a:view.win_layout)
  execute a:view.win_resize_cmd
  call s:go_to_win(a:view.cursor.winnr)
  call setpos('.', a:view.cursor.position)
endfunction

function! s:restore_layout(layout) abort
  if a:layout[0] ==# 'leaf'
    if bufexists(a:layout[1])
      execute printf('buffer %d', a:layout[1])
    endif
  else
    let split_cmd = 'rightb ' . (a:layout[0] ==# 'col' ? 'split' : 'vsplit')
    let windows = [win_getid()]
    for i in range(len(a:layout[1]) - 1)
      execute split_cmd
      let windows = windows->add(win_getid())
    endfor
    for i in range(len(windows))
      call win_gotoid(windows[i])
      call s:restore_layout(a:layout[1][i])
    endfor
  endif
endfunction

function! s:go_to_win(winnr) abort
  execute printf("%dwincmd w", a:winnr)
endfunction

function! s:warn(msg) abort
  echohl WarningMsg | echomsg '[zoom]' a:msg | echohl None
endfunction

function! s:zoom_out_on_exit() abort
  if get(g:, 'zoom_out_on_exit', 1) && s:is_zoomed()
    split
    call s:zoom_out()
  endif
endfunction

function! s:lock_zoomed_window() abort
  if s:is_zoomed() && s:is_ordinary(winbufnr(0))
    let windows = range(winnr('$'), 1, -1)
    let ordinary = windows->filter({_, win -> s:is_ordinary(winbufnr(win))})
    if len(ordinary) ># 1
      quit
      call s:warn('Cannot split zoomed window')
    elseif winbufnr(0) !=# t:zoom_zoomed_bufnr
      execute "silent! buffer " . t:zoom_zoomed_bufnr
      call s:warn('Cannot switch buffer in zoomed window')
    endif
  endif
endfunction

function! s:is_ordinary(bufnr) abort
  return bufexists(a:bufnr) && buflisted(a:bufnr)
        \ && getbufvar(a:bufnr, '&buftype') ==# ''
endfunction

augroup Zoom
  autocmd!
  autocmd SafeState * call <sid>lock_zoomed_window()
  autocmd ExitPre * call <sid>zoom_out_on_exit()
augroup END

noremap <silent> <script> <plug>(zoom) :<c-u>call <sid>toggle_zoom()<cr>

let &cpo = s:cpo
unlet! s:cpo
