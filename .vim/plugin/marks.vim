vim9script

import autoload '../autoload/message.vim'

const LETTERS: list<string> = 'abcdefghijklmnopqrstuvwxyz'->split('\zs')

def Mark(): void
  const marks = getmarklist('%')->filter((_, m) => m.mark[1] =~ '[a-z]')
  const position = getpos('.')[1 : 3]
  if marks->indexof((_, m) => m.pos[1 : 3] == position) < 0
    if marks->len() < LETTERS->len()
      const next = LETTERS->indexof(
        (_, l) => marks->indexof((_, m) => m.mark[1] == l) < 0
      )
      silent! execute 'normal! m' .. LETTERS[next]
    else
      message.warn('Maximum number of marks reached')
    endif
  endif
enddef

nnoremap mm <scriptcmd> Mark()<cr>
