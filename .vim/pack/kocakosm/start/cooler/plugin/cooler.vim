vim9script noclear

#--------------------------------------------------------------------#
# vim-cooler - Disable hlsearch when you are done searching          #
# Forked from https://github.com/romainl/vim-cool version 0.0.2      #
# Licensed under the MIT license <http//opensource.org/licenses/MIT> #
#--------------------------------------------------------------------#

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
  # FIXME: doesn't work when searching backward a single character and it is the last character of a line
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

augroup __Cooler__
  autocmd!
augroup END

def Enable(): void
  nnoremap <silent> <plug>(cooler#nohlsearch) <cmd>nohlsearch<cr>
  inoremap <silent> <plug>(cooler#nohlsearch) <cmd>nohlsearch<cr>
  autocmd __Cooler__ CursorMoved * CheckHighlight()
  autocmd __Cooler__ InsertEnter * StopHighlight()
enddef

def Disable(): void
  nunmap <plug>(cooler#nohlsearch)
  iunmap <plug>(cooler#nohlsearch)
  autocmd! __Cooler__ CursorMoved
  autocmd! __Cooler__ InsertEnter
enddef

def PlayItCool(hlsearch: bool): void
  if hlsearch
    Enable()
  else
    Disable()
  endif
enddef

autocmd __Cooler__ OptionSet hlsearch PlayItCool(v:option_new == '1')

PlayItCool(&hlsearch)
