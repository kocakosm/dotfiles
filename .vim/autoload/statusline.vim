vim9script

const MODES = {
  'n': 'NORMAL',
  'v': 'VISUAL',
  'V': 'V·LINE',
  '': 'V·BLOCK',
  's': 'SELECT',
  'S': 'S·LINE',
  '': 'S·BLOCK',
  'i': 'INSERT',
  'R': 'REPLACE',
  'c': 'COMMAND',
  'r': 'PROMPT',
  '!': 'SHELL',
  't': 'TERMINAL'
}

export def Mode(): string
  return MODES->get(mode(), '')
enddef

export def GitHead(): string
  const h = git#Head()
  return ' ' .. (empty(h) ? 'N/A' : h)
enddef

export def Filename(): string
  const filename = expand('%:t')
  return empty(filename) ? '[New]' : filename
enddef

export def FileInfo(): string
  var info = Filename()
  const ft = tolower(&filetype)
  if !empty(ft) && !string#EndsWith(info, ft)
    info ..= $' ({ft})'
  endif
  const locked = &readonly || !&modifiable
  return (locked ? ' ' : '') .. info .. (&modified ? ' ●' : '')
enddef

export def BufferType(): string
  if &buftype == 'quickfix'
    const win = win_getid()
    if IsLocationList(win)
      const total = getloclist(win, {nr: '$'}).nr
      if total > 1
        const current = getloclist(win, {nr: 0}).nr
        return $'Location List ({current}/{total})'
      endif
      return 'Location List'
    else
      const total = getqflist({nr: '$'}).nr
      if total > 1
        const current = getqflist({nr: 0}).nr
        return $'Quickfix ({current}/{total})'
      endif
      return 'Quickfix'
    endif
  elseif &buftype == 'help' || &buftype == 'terminal'
    return string#Capitalize(&buftype)
  elseif !empty(&buftype)
    return string#Capitalize(&filetype)
  endif
  return ''
enddef

export def QuickfixTitle(): string
  if IsLocationList(win_getid())
    return getloclist(0, {title: 1}).title
  endif
  return getqflist({title: 1}).title
enddef

def IsLocationList(winid: number): bool
  return win_gettype(winid) == 'loclist'
enddef

export def FileFormat(): string
  return &fileformat .. ' ' .. (empty(&fileencoding) ? &encoding : &fileencoding)
enddef

export def SpellLang(): string
  return &spell ? toupper(&spelllang) : ''
enddef
