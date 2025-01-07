vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# gui-zoom.vim                                                         #
# Easily increase/decrease GUI font size                               #
# Copyright (c) Osman Koçak <kocakosm@gmail.com>                       #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:loaded_gui_zoom') || &cp || !has('gui_running')
  finish
endif
g:loaded_gui_zoom = 1

const GUI_FONT_SIZE_PATTERN = '\d\+$'

def GetCurrentFontSize(): number
  return &guifont->matchstr(GUI_FONT_SIZE_PATTERN)->str2nr()
enddef

def IncreaseFontSize(): void
  if GetCurrentFontSize() < g:->get('gui_zoom_max_font_size', 32)
    &guifont = &guifont->substitute(GUI_FONT_SIZE_PATTERN, (m) => str2nr(m[0]) + 1, '')
  endif
enddef

def DecreaseFontSize(): void
  if GetCurrentFontSize() > g:->get('gui_zoom_min_font_size', 8)
    &guifont = &guifont->substitute(GUI_FONT_SIZE_PATTERN, (m) => str2nr(m[0]) - 1, '')
  endif
enddef

def RestoreFontSize(): void
  &guifont = &guifont->substitute(GUI_FONT_SIZE_PATTERN, DEFAULT_FONT_SIZE, '')
enddef

def IsMapped(name: string, mode: string): bool
  return !maparg(name, mode)->empty()
enddef

const DEFAULT_FONT_SIZE = GetCurrentFontSize()

if !IsMapped('<c-scrollwheelup>', 'n') && !IsMapped('<c-scrollwheeldown>', 'n')
  nnoremap <silent> <c-scrollwheelup> <scriptcmd>IncreaseFontSize()<cr>
  nnoremap <silent> <c-scrollwheeldown> <scriptcmd>DecreaseFontSize()<cr>
endif

if !IsMapped('<c-scrollwheelup>', 'i') && !IsMapped('<c-scrollwheeldown>', 'i')
  inoremap <silent> <c-scrollwheelup> <scriptcmd>IncreaseFontSize()<cr>
  inoremap <silent> <c-scrollwheeldown> <scriptcmd>DecreaseFontSize()<cr>
endif

command! -bar GuiZoomIn IncreaseFontSize()
command! -bar GuiZoomOut DecreaseFontSize()
command! -bar GuiZoomRestore RestoreFontSize()
