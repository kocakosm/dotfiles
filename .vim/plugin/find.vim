vim9script

if executable('fd')
  &findfunc = (arg: string, complete: bool): list<string> => {
    const case_option = &ignorecase ? (&smartcase ? '' : '-i') : '-s'
    const excludes = &wildignore->split(',')->map((_, v) => $"'-E {v}'")->join()
    return systemlist($'fd --type f --hidden --follow --full-path --color never {case_option} {excludes} {arg}')
  }
endif
