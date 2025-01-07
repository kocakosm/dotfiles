vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# spyglass.vim                                                         #
# Copyright (c) Osman Koçak <kocakosm@gmail.com>                       #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:autoloaded_spyglass') || &cp
  finish
endif
g:autoloaded_spyglass = 1

import autoload './spyglass/popup.vim'
import autoload './spyglass/actions.vim'

export def Buffers(): void
  popup.Create(
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
      "\<C-s>": actions.CONFIRM,
      "\<C-v>": actions.CONFIRM,
      "\<C-t>": actions.CONFIRM
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
    name ..= ' ●'
  endif
  return name
enddef

export def Files(path: string = ''): void
  if !executable('fd')
    throw 'spyglass: fd not available'
  endif
  const dir = isdirectory(expand(path)) ? path : fnamemodify(path, ':h')
  const excludes = &wildignore->split(',')->map((_, v) => $"'-E {v}'")->join()
  const cmd = $'fd --type f --hidden --follow --no-ignore-vcs --color never {excludes} . {dir}'
  popup.Create(
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
        execute $':edit {selected.text}'
      endif
    },
    expand('%:~:.'),
    {
      "\<C-s>": actions.CONFIRM,
      "\<C-v>": actions.CONFIRM,
      "\<C-t>": actions.CONFIRM
    }
  )
enddef

export def RecentlyUsed()
  popup.Create(
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
      "\<C-s>": actions.CONFIRM,
      "\<C-v>": actions.CONFIRM,
      "\<C-t>": actions.CONFIRM
    }
  )
enddef
