vim9script noclear
scriptencoding utf-8
#------------------------------------------------------------------------#
# cooler.vim                                                             #
# Disables hlsearch when you are done searching                          #
# Forked from https://github.com/romainl/vim-cool version 0.0.2          #
# Copyright (c) 2016-2021 Romain Lafourcade <romainlafourcade@gmail.com> #
# Copyright (c) 2022 Osman Koçak <kocakosm@gmail.com>                    #
# Licensed under the MIT license <https://opensource.org/licenses/MIT>   #
#------------------------------------------------------------------------#

if exists('g:loaded_cooler') || &compatible
  finish
endif
g:loaded_cooler = 1

def CheckHighlight(): void
  if !v:hlsearch || mode() != 'n'
    return
  endif
  const current_view = winsaveview()
  const cursor_position = getpos('.')
  silent! execute 'keepjumps goto ' .. (line2byte('.') + col('.') - (v:searchforward ? 2 : 0))
  try
    silent keepjumps normal! n
    if getpos('.') != cursor_position
      StopHighlight()
    endif
  catch /^\%(0$\|Vim\%(\w\|:Interrupt$\)\@!\)/
    StopHighlight()
  finally
    winrestview(current_view)
  endtry
enddef

def StopHighlight(): void
  if !v:hlsearch || mode() != 'n'
    return
  endif
  silent feedkeys("\<plug>(cooler#nohlsearch)", 'm')
enddef

nnoremap <silent> <plug>(cooler#nohlsearch) <cmd>nohlsearch<cr>
inoremap <silent> <plug>(cooler#nohlsearch) <cmd>nohlsearch<cr>

augroup __Cooler__
  autocmd!
augroup END

def PlayItCool(hlsearch: bool): void
  if hlsearch
    autocmd __Cooler__ CursorMoved * CheckHighlight()
    autocmd __Cooler__ InsertEnter * StopHighlight()
  else
    autocmd! __Cooler__ CursorMoved
    autocmd! __Cooler__ InsertEnter
  endif
enddef

autocmd __Cooler__ OptionSet hlsearch PlayItCool(v:option_new == '1')

PlayItCool(&hlsearch)
