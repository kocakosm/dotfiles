vim9script

g:pairs = {
  default: [['{', '}'], ['(', ')'], ['[', ']'], ['"', '"'], ["'", "'"]],
  vim: [['{', '}'], ['(', ')'], ['[', ']'], ["'", "'"]],
}

def GetPairs(): list<list<string>>
  const pairs = g:->get('pairs', {})
  return pairs->get(&ft, pairs->get('default', []))
enddef

def IsInPair(): bool
  const line = getline('.')
  const cursor = getcursorcharpos()[2]
  for pair in GetPairs()
    if line[cursor - 2] == pair[0] && line[cursor - 1] == pair[1]
      return true
    endif
  endfor
  return false
enddef

augroup AutoPairs
  autocmd!
  autocmd FileType * {
    const pairs = GetPairs()
    if !pairs->empty()
      const options = {global: 0}
      execute keymap#conditional('i', 'IsInPair()', '<cr>', '<cr><up><end><cr>', options)
      execute keymap#conditional('i', 'IsInPair()', '<c-h>', '<backspace><del>', options)
      execute keymap#conditional('i', 'IsInPair()', '<backspace>', '<backspace><del>', options)
      for pair in pairs
        execute $'inoremap <silent> <buffer> {pair[0]} {pair[0]}{pair[1]}<left>'
      endfor
    endif
  }
augroup END
