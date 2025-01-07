vim9script

if executable('fd')
  &findfunc = (arg: string, complete: bool): list<string> => {
    const excludes = &wildignore->split(',')->map((_, v) => $"'-E {v}'")->join()
    return systemlist($'fd --type f --hidden --ignore-case --full-path --color never {excludes} {arg}')
  }
endif
