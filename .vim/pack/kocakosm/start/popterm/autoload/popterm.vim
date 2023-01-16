vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# popterm.vim                                                          #
# Copyright (c) 2022-2023 Osman Koçak <kocakosm@gmail.com>             #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:autoloaded_popterm') || v:version < 900 || &cp
  finish
endif
g:autoloaded_popterm = 1

highlight default link PopTerm Normal
highlight default link PopTermBorder Normal
highlight default link PopTermBorderTop PopTermBorder
highlight default link PopTermBorderRight PopTermBorder
highlight default link PopTermBorderBottom PopTermBorder
highlight default link PopTermBorderLeft PopTermBorder

final popup = {
  id: 0,
  visible: false
}

export def Toggle(): void
  const popup_pos = popup_getpos(popup.id)
  if popup_pos->empty()
    OpenPopup()
    popup.visible = true
  elseif popup_pos.visible
    ClosePopup()
    popup.visible = false
  endif
enddef

def ClosePopup(): void
  if popup.id > 0
    popup_close(popup.id)
    popup.id = 0
  endif
enddef

def OpenPopup(): void
  const cmd = g:->get('popterm_cmd', &shell)
  if !TerminalExists(t:->get('terminal_buf_nr', -1))
    const terminal_options = {
      hidden: 1,
      term_kill: 'term',
      term_finish: 'close'
    }
    t:terminal_buf_nr = term_start(cmd, terminal_options)
    if !bufexists(t:->get('terminal_buf_nr', -1))
      Warn('Failed to execute ' .. cmd)
      return
    endif
    setbufvar(t:terminal_buf_nr, '&buflisted', 0)
  endif
  # const width = float2nr(&columns * g:->get('popterm_width', 0.75))
  # const height = float2nr(&lines * g:->get('popterm_height', 0.75))
  # const popup_options = {
  #   minwidth: width,
  #   maxwidth: width,
  #   minheight: height,
  #   maxheight: height,
  #   border: [],
  #   title: $' {cmd} ',
  #   padding: [0, 0, 0, 0],
  #   highlight: 'PopTerm',
  #   borderhighlight: ['PopTermBorderTop', 'PopTermBorderRight', 'PopTermBorderBottom', 'PopTermBorderLeft'],
  #   borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
  # }
  const width = float2nr(&columns * g:->get('popterm_width', 1))
  const height = float2nr(&lines * g:->get('popterm_height', 0.4))
  const popup_options = {
    line: &lines - height,
    minwidth: width,
    maxwidth: width,
    minheight: height,
    maxheight: height,
    border: [1, 0, 0, 0],
    title: $' {cmd} ',
    padding: [0, 0, 0, 0],
    highlight: 'PopTerm',
    borderhighlight: ['PopTermBorderTop'],
    borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
  }
  popup.id = popup_create(t:terminal_buf_nr, popup_options)
enddef

def TerminalExists(buf_nr: number): bool
  if bufexists(buf_nr)
    const term_job = term_getjob(buf_nr)
    return term_job != null && job_status(term_job) == 'run'
  endif
  return false
enddef

def Warn(msg: string): void
  echohl WarningMsg | echomsg '[popterm]' msg | echohl None
enddef

def OnBufEnter(): void
  if popup.visible && &buftype == 'terminal'
    silent! execute 'normal! i'
  endif
enddef

def OnVimResized(): void
  if popup.visible
    ClosePopup()
    OpenPopup()
  endif
enddef

def OnTabLeave(): void
  if popup.visible
    ClosePopup()
  endif
enddef

def OnTabEnter(): void
  if popup.visible
    OpenPopup()
  endif
enddef

def OnQuitPre(): void
  if bufexists(t:->get('terminal_buf_nr', -1))
    execute 'silent! bdelete! ' .. t:terminal_buf_nr
  endif
enddef

augroup __PopTerm__
  autocmd!
  autocmd BufEnter * OnBufEnter()
  autocmd VimResized * OnVimResized()
  autocmd TabLeave * OnTabLeave()
  autocmd TabEnter * OnTabEnter()
  autocmd QuitPre * OnQuitPre()
augroup END
