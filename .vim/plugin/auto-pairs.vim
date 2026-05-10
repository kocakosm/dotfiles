vim9script

# TODO:
# - filetype autocmd: unmap current mappings before defining new mappings
# - define commands to enable/disable the plugin

g:pairs = {
  default: [['{', '}'], ['(', ')'], ['[', ']'], ['"', '"'], ["'", "'"], ['`', '`']],
  vim: [['{', '}'], ['(', ')'], ['[', ']'], ["'", "'"]],
}

def GetPairs(): list<list<string>>
  const pairs = g:->get('pairs', {})
  return pairs->get(&ft, pairs->get('default', []))
enddef

def IsInPair(): bool
  const previous = GetPreviousCharacter()
  const next = GetNextCharacter()
  const p = GetPairs()->copy()->filter((_, p) => p[0] == previous)->flattennew()
  if !p->empty() && p[1] == next
    const buf = bufnr()
    const last_line = line('$')
    if (p[0] == p[1])
      return matchbufline(buf, p[0], 1, last_line)->len() % 2 == 0
    else
      return matchbufline(buf, p[0], 1, last_line)->len() == matchbufline(buf, p[1], 1, last_line)->len()
    endif
  endif
  return false
enddef

def ShouldAutoClose(c: string): bool
  const pairs = GetPairs()
  const next = GetNextCharacter()->trim()
  if pairs->copy()->filter((_, p) => p[0] == p[1] && p[0] == c)->empty()
    return next->empty() || pairs->mapnew((_, p) => p[1])->index(next) >= 0
  else
    const previous = GetPreviousCharacter()->trim()
    return (next->empty() || pairs->mapnew((_, p) => p[1])->index(next) >= 0)
      && (previous->empty() || pairs->mapnew((_, p) => p[0])->index(previous) >= 0)
  endif
enddef

def GetNextCharacter(): string
  return getline('.')->strcharpart(getcursorcharpos()[2] - 1, 1)
enddef

def GetPreviousCharacter(): string
  return getline('.')->strcharpart(getcursorcharpos()[2] - 2, 1)
enddef

def ConditionalIMap(condition: string, lhs: string, rhs: string): void
  execute keymap#conditional('i', condition, lhs, rhs, {global: 0})
enddef

augroup AutoPairs
  autocmd!
  autocmd FileType * {
    const pairs = GetPairs()
    if !pairs->empty()
      ConditionalIMap('IsInPair()', '<cr>', '<cr><up><end><cr>')
      ConditionalIMap('IsInPair()', '<c-h>', '<backspace><del>')
      ConditionalIMap('IsInPair()', '<backspace>', '<backspace><del>')
      for p in pairs
        ConditionalIMap($'ShouldAutoClose("{p[0]->escape('"')}")', p[0], $'{p[0]}{p[1]}<left>')
        ConditionalIMap($'GetNextCharacter() == "{p[1]->escape('"')}"', p[1], '<right>')
      endfor
    endif
  }
augroup END
