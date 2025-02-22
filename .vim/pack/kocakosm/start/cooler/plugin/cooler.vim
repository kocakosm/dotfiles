vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# cooler.vim                                                           #
# Disables hlsearch when you are done searching                        #
# Inspired by https://github.com/romainl/vim-cool version 0.0.2        #
# Copyright (c) Osman Koçak <kocakosm@gmail.com>                       #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:loaded_cooler') || &cp
  finish
endif
g:loaded_cooler = 1

def CheckHighlight(): void
  if v:hlsearch && @/ != null
    const search_flags = (v:searchforward ? '' : 'b') .. 'cnw'
    if getcurpos()[1 : 2] != searchpos(@/, search_flags)
      StopHighlight()
    endif
  endif
enddef

def StopHighlight(): void
  if v:hlsearch && index(['n', 'v', 'V', ''], mode()) >= 0
    silent feedkeys("\<plug>(cooler#nohlsearch)", 'm')
  endif
enddef

nnoremap <silent> <plug>(cooler#nohlsearch) <cmd>nohlsearch<cr>
inoremap <silent> <plug>(cooler#nohlsearch) <cmd>nohlsearch<cr>
xnoremap <silent> <plug>(cooler#nohlsearch) <cmd>nohlsearch<cr>

augroup __Cooler__ | autocmd! | augroup END

def Cooler(hlsearch: bool): void
  autocmd! __Cooler__ CursorMoved,WinEnter,InsertEnter
  if hlsearch
    if !getreg('/')->empty() | CheckHighlight() | endif
    autocmd __Cooler__ CursorMoved,WinEnter * CheckHighlight()
    autocmd __Cooler__ InsertEnter * StopHighlight()
  endif
enddef

autocmd __Cooler__ OptionSet hlsearch Cooler(v:option_new == '1')

Cooler(&hlsearch)
