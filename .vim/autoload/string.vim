vim9script

export def Capitalize(input: string): string
  return toupper(strcharpart(input, 0, 1)) .. tolower(strcharpart(input, 1))
enddef

export def Abbreviate(input: string, length: number, ellipsis: string): string
  if strchars(ellipsis) > length
    throw 'string#Abbreviate: ellipsis is longer than desired length'
  endif
  if strchars(input) <= length
    return input
  endif
  return strcharpart(input, 0, length - strchars(ellipsis)) .. ellipsis
enddef
