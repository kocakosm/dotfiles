vim9script

const INDENT_GUIDE = '┊'
const FILE_TYPES = ['java', 'vim', 'xml']

final listeners: dict<number> = {}
prop_type_add('indent-guides', {highlight: 'SpecialKey'})

def IndentGuides(): void
  const bufnr = bufnr()
  Cleanup(bufnr)
  if &list && FILE_TYPES->index(&filetype) >= 0
    listeners[bufnr] = listener_add(OnBufferUpdate)
    UpdateIndentGuides()
    UpdateIndentGuidesOnEmptyLines(1, line('$'))
  endif
enddef

def Cleanup(bufnr: number): void
  if listeners->has_key(bufnr)
    listener_remove(listeners->remove(bufnr))
    prop_remove({type: 'indent-guides', bufnr: bufnr})
  endif
enddef

def UpdateIndentGuides(): void
  const GetListCharsItem = (name: string) => {
    return &listchars->matchstr($'{name}:\([^,]*\)')->escape(' ')
  }
  execute('setlocal listchars-=' .. GetListCharsItem('leadmultispace'))
  execute('setlocal listchars-=' .. GetListCharsItem('tab'))
  if &expandtab
    &l:listchars ..= ',leadmultispace:' .. GetIndentGuide()
  else
    &l:listchars ..= ',tab:' .. GetIndentGuide()->strcharpart(0, 2)
  endif
enddef

def GetIndentGuide(): string
  return INDENT_GUIDE .. repeat(' ', shiftwidth() - 1)
enddef

def OnBufferUpdate(bufnr: number, start: number, end: number, added: number, changes: list<any>): void
  UpdateIndentGuidesOnEmptyLines(
    min([line('$'), max([1, min([start, end + added - 1])])]),
    min([line('$'), max([1, max([start, end + added - 1])])])
  )
enddef

def UpdateIndentGuidesOnEmptyLines(start: number, end: number): void
  prop_remove({type: 'indent-guides', all: true}, start, end)
  const GetIndent = (linenr: number) => linenr > 0 ? indent(linenr) : 0
  for linenr in range(start, end)
    if empty(getline(linenr))
      const previous_indent = GetIndent(prevnonblank(linenr))
      const next_indent = GetIndent(nextnonblank(linenr))
      const indent = max([previous_indent, next_indent])
      const guide = GetIndentGuide()->repeat(indent / shiftwidth())
      prop_add(linenr, 1, {type: 'indent-guides', text: guide})
    endif
  endfor
enddef

augroup __IndentGuides__
  autocmd!
  autocmd FileType * IndentGuides()
  autocmd OptionSet list,expandtab,shiftwidth IndentGuides()
  autocmd BufDelete * Cleanup(str2nr(expand('<abuf>')))
augroup END
