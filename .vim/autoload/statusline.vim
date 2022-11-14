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
  return empty(h) ? '' : ' ' .. h
enddef

export def Filename(): string
  const filename = expand('%:t')
  return empty(filename) ? '[New]' : filename
enddef

export def FileInfo(): string
  return ((&readonly || !&modifiable) ? ' ' : '')
         .. Filename() .. (&modified ? ' ∙' : '')
enddef

export def BufferType(): string
  if &buftype == 'quickfix'
    return IsLocationList(win_getid()) ? 'Location List' : 'Quickfix'
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

export def FileType(): string
  return tolower(&filetype)
enddef

export def FileFormat(): string
  return &fileformat .. ' ' .. (empty(&fileencoding) ? &encoding : &fileencoding)
enddef

export def SearchCount(): string
  if v:hlsearch
    try
      const c = searchcount({maxcount: 0})
      if !empty(c)
        const searched = string#Abbreviate(@/, 16, '...')
        return printf('/%s [%s/%s]', searched, c.current, c.incomplete ? '??' : c.total)
      endif
    catch
    endtry
  endif
  return ''
enddef

export def SpellLang(): string
  return &spell ? toupper(&spelllang) : ''
enddef
