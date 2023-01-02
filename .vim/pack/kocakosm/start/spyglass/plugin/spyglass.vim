vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# spyglass.vim                                                         #
# Copyright (c) 2023 Osman Koçak <kocakosm@gmail.com>                  #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:loaded_spyglass') || &cp
  finish
endif
g:loaded_spyglass = 1

import autoload '../autoload/popup.vim'

def Buffers(): void
  popup.Filter(
    'Buffers',
    getbufinfo({'buflisted': 1})->mapnew((_, b) => {
      return {bufnr: b.bufnr, text: FormatBufferName(b)}
    }),
    (selected, key) => {
      if key == "\<C-s>"
        execute $':sbuffer {selected.bufnr}'
      elseif key == "\<C-v>"
        execute $':vertical sbuffer {selected.bufnr}'
      elseif key == "\<C-t>"
        execute $':tab sbuffer {selected.bufnr}'
      else
        execute $':buffer {selected.bufnr}'
      endif
    },
    FormatBufferName(getbufinfo('%')[0]),
    {
      "\<C-s>": 'SELECT',
      "\<C-v>": 'SELECT',
      "\<C-t>": 'SELECT'
    }
  )
enddef

def FormatBufferName(buffer: dict<any>): string
  var name = $'[{buffer.bufnr}] '
  if empty(buffer.name)
    name ..= 'No Name'
  else
    name ..= fnamemodify(buffer.name, ':~:.')
  endif
  if buffer.changed
    name ..= ' ∙'
  endif
  return name
enddef

def Files(path: string = ''): void
  if !executable('fd')
    throw 'spyglass: fd not available'
  endif
  const dir = isdirectory(expand(path)) ? path : fnamemodify(path, ':h')
  const cmd = 'fd --type f --hidden --follow --no-ignore-vcs . ' .. dir
  popup.Filter(
    'Files',
    systemlist(cmd)->map((_, v) => fnamemodify(v, ':~:.')),
    (selected, key) => {
      if key == "\<C-s>"
        execute $':split {selected.text}'
      elseif key == "\<C-v>"
        execute $':vertical split {selected.text}'
      elseif key == "\<C-t>"
        execute $':tabedit {selected.text}'
      else
        exe $':edit {selected.text}'
      endif
    },
    expand('%:~:.'),
    {
      "\<C-s>": 'SELECT',
      "\<C-v>": 'SELECT',
      "\<C-t>": 'SELECT'
    }
  )
enddef

def RecentlyUsed()
  popup.Filter(
    'Recently used',
    v:oldfiles->filter((_, v) => filereadable(expand(v)))
              ->mapnew((_, v) => fnamemodify(v, ':~')),
    (selected, key) => {
      if key == "\<C-s>"
        execute $':split {selected.text}'
      elseif key == "\<C-v>"
        execute $':vertical split {selected.text}'
      elseif key == "\<C-t>"
        execute $':tabedit {selected.text}'
      else
        execute $':edit {selected.text}'
      endif
    },
    expand('%:~'),
    {
      "\<C-s>": 'SELECT',
      "\<C-v>": 'SELECT',
      "\<C-t>": 'SELECT'
    }
  )
enddef

command! Buffers Buffers()
command! -nargs=? -complete=file Files Files(<f-args>)
command! RecentlyUsed RecentlyUsed()
