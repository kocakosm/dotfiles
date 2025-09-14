vim9script

const TOGGLE_WORDS = [
  ['==', '!='], ['>', '<'], ['>=', '<='],
  ['(', ')'], ['[', ']'], ['{', '}'],
  ['+', '-'], ['*', '/'],
  ['allow', 'deny'],
  ['before', 'after'],
  ['in', 'out'],
  ['min', 'max'],
  ['on', 'off'],
  ['start', 'stop'],
  ['success', 'failure'],
  ['true', 'false'], ['yes', 'no'], ['1', '0'],
  ['up', 'down'], ['top', 'bottom'], ['left', 'right']
]

enum Case
  UPPER((word) => toupper(word)),
  LOWER((word) => tolower(word)),
  TITLE((word) => substitute(word, '.*', '\u\L\0', ''))
  const Apply: func(string): string
  static def Of(word: string): Case
    for case in values
      if word == case.Apply(word)
        return case
      endif
    endfor
    return LOWER
  enddef
endenum

def ToggleWord(): void
	const cword = expand('<cword>')
  const case = Case.Of(cword)
	for words in GetWords()
		const index = index(words->mapnew((_, w) => tolower(w)), tolower(cword))
		if index > -1
			execute 'normal! ciw' .. case.Apply(words[(index + 1) % len(words)])
			break
		endif
	endfor
enddef

def GetWords(): list<list<string>>
  const words = g:->get('toggle_words', {})
  return words->get(&filetype, [])->extendnew(words->get('*', []))->extend(TOGGLE_WORDS)
enddef

command! ToggleWord ToggleWord()
