scriptencoding utf-8
"----------------------------------------------------------------------"
" popterm.vim                                                          "
" Copyright (c) 2022 Osman Koçak <kocakosm@gmail.com>                  "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:autoloaded_popterm') || v:version < 900 || &cp
  finish
endif
let g:autoloaded_popterm = 1

let s:cpo = &cpo
set cpo&vim

let s:popup_id = 0
let s:popup_visible = 0

function! popterm#toggle() abort
  let popup_pos = popup_getpos(s:popup_id)
  if popup_pos->empty()
    call s:open_popup()
    let s:popup_visible = 1
  elseif popup_pos.visible
    call s:close_popup()
    let s:popup_visible = 0
  endif
endfunction

function! s:close_popup() abort
  if s:popup_id
    call popup_close(s:popup_id)
    let s:popup_id = 0
  endif
endfunction

function! s:open_popup() abort
  let cmd = g:->get('popterm_cmd', &shell)
  if !s:terminal_exists(t:->get('terminal_buf_nr', -1))
    let terminal_options = #{
    \  hidden: 1,
    \  term_kill: 'term',
    \  term_finish: 'close'
    \}
    let t:terminal_buf_nr = term_start(cmd, terminal_options)
    if !bufexists(t:->get('terminal_buf_nr', -1))
      call s:warn('Failed to execute ' . cmd)
      return
    endif
    call setbufvar(t:terminal_buf_nr, '&buflisted', 0)
  endif
  let width = float2nr(&columns * g:->get('popterm_width', 0.75))
  let height = float2nr(&lines * g:->get('popterm_height', 0.75))
  let popup_options = #{
  \  minwidth: width,
  \  maxwidth: width,
  \  minheight: height,
  \  maxheight: height,
  \  border: [],
  \  title: ' ' . cmd . ' ',
  \  padding: [0, 0, 0, 0],
  \  highlight: 'Normal',
  \  borderhighlight: ['Normal'],
  \  borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
  \}
  let s:popup_id = popup_create(t:terminal_buf_nr, popup_options)
endfunction

function! s:terminal_exists(buf_nr) abort
  if bufexists(a:buf_nr)
    let term_job = term_getjob(a:buf_nr)
    return term_job != v:null && term_job !~? 'dead'
  endif
  return 0
endfunction

function! s:warn(msg) abort
  echohl WarningMsg | echomsg '[popterm]' a:msg | echohl None
endfunction

function! s:on_buf_enter() abort
  if s:popup_visible && &buftype ==# 'terminal'
    silent! execute 'normal! i'
  endif
endfunction

function s:on_vim_resized() abort
  if s:popup_visible
    call s:close_popup()
    call s:open_popup()
  endif
endfunction

function! s:on_tab_leave() abort
  if s:popup_visible
    call s:close_popup()
  endif
endfunction

function! s:on_tab_enter() abort
  if s:popup_visible
    call s:open_popup()
  endif
endfunction

function! s:on_quit_pre() abort
  if bufexists(t:->get('terminal_buf_nr', -1))
    execute 'silent! bdelete! ' . t:terminal_buf_nr
  endif
endfunction

augroup __PopTerm__
  autocmd!
  autocmd BufEnter * call <sid>on_buf_enter()
  autocmd VimResized * call <sid>on_vim_resized()
  autocmd TabLeave * call <sid>on_tab_leave()
  autocmd TabEnter * call <sid>on_tab_enter()
  autocmd QuitPre * call <sid>on_quit_pre()
augroup END

let &cpo = s:cpo
unlet! s:cpo
