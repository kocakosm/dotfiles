vim9script

import autoload '../autoload/message.vim'

enum Scope
  LOCAL('[a-z]', 'abcdefghijklmnopqrstuvwxyz'->split('\zs'), () => getmarklist('')),
  GLOBAL('[A-Z]', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'->split('\zs'), () => getmarklist())
  const pattern: string
  const letters: list<string>
  const Marks: func(): list<dict<any>>
endenum

def Mark(scope: Scope): void
  const marks = scope.Marks()->filter((_, m) => m.mark[1] =~ scope.pattern)
  const position = getpos('.')[1 : 3]
  if marks->indexof((_, m) => m.pos[1 : 3] == position) < 0
    if marks->len() < scope.letters->len()
      const next = scope.letters->indexof(
        (_, l) => marks->indexof((_, m) => m.mark[1] == l) < 0
      )
      silent! execute $'normal! m{scope.letters[next]}'
    else
      message.warn('Maximum number of marks reached')
    endif
  endif
enddef

nnoremap mm <scriptcmd> Mark(Scope.LOCAL)<cr>
nnoremap mM <scriptcmd> Mark(Scope.GLOBAL)<cr>
