vim9script

# TODO:
# - filetype autocmd: unmap current mappings before defining new mappings
# - define commands to enable/disable the plugin

const PAIRS = {
  default: [['{', '}'], ['(', ')'], ['[', ']'], ['"', '"'], ["'", "'"], ['`', '`']],
  vim: [['{', '}'], ['(', ')'], ['[', ']'], ["'", "'"]],
}

def GetPairs(): list<list<string>>
  return PAIRS->get(&ft, PAIRS.default)
enddef

def IsInPair(): bool
  const previous = GetPreviousCharacter()
  const next = GetNextCharacter()
  const p = GetPairs()->copy()->filter((_, p) => p[0] == previous && p[1] == next)->flattennew()
  return !p->empty() && (p[0] == p[1] || CountOccurences(p[0]) == CountOccurences(p[1]))
enddef

def CountOccurences(c: string): number
  return matchbufline('%', c, 1, '$')->len()
enddef

def ShouldAutoClose(c: string): bool
  const pairs = GetPairs()
  const next = GetNextCharacter()->trim()
  if pairs->copy()->filter((_, p) => p[0] == p[1] && p[0] == c)->empty()
    return next->empty() || pairs->mapnew((_, p) => p[1])->index(next) >= 0
  else
    const previous = GetPreviousCharacter()->trim()
    return previous != c
      && (next->empty() || pairs->mapnew((_, p) => p[1])->index(next) >= 0)
      && (previous->empty() || pairs->mapnew((_, p) => p[0])->index(previous) >= 0)
  endif
enddef

def GetPreviousCharacter(): string
  return getline('.')->strcharpart(getcursorcharpos()[2] - 2, 1)
enddef

def GetNextCharacter(): string
  return getline('.')->strcharpart(getcursorcharpos()[2] - 1, 1)
enddef

def IsNextCharacter(c: string): bool
  return GetNextCharacter() == c
enddef

def ConditionalIMap(condition: string, lhs: string, rhs: string): void
  execute keymap#conditional('i', condition, lhs, rhs, {global: 0})
enddef

augroup AutoPairs
  autocmd!
  autocmd FileType * {
    ConditionalIMap('IsInPair()', '<cr>', '<cr><up><end><cr>')
    ConditionalIMap('IsInPair()', '<c-h>', '<backspace><del>')
    ConditionalIMap('IsInPair()', '<backspace>', '<backspace><del>')
    for p in GetPairs()
      ConditionalIMap($'ShouldAutoClose("{p[0]->escape('"')}")', p[0], $'{p[0]}{p[1]}<left>')
      ConditionalIMap($'IsNextCharacter("{p[1]->escape('"')}")', p[1], '<right>')
    endfor
  }
augroup END
