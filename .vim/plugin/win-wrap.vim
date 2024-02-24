vim9script

const directions = {
  'h': {opposite: 'l', mappings: ['h', '<c-h>', '<left>', '<c-left>', '<bs>']},
  'l': {opposite: 'h', mappings: ['l', '<c-l>', '<right>', '<c-right>']},
  'j': {opposite: 'k', mappings: ['j', '<c-j>', '<down>', '<c-down>']},
  'k': {opposite: 'j', mappings: ['k', '<c-k>', '<up>', '<c-up>']}
}

def NextWindow(direction: string, count: number): void
  for i in range(count)
    const winnr = winnr()
    execute 'wincmd' direction
    if winnr() == winnr
      execute ':' winnr('$') 'wincmd' directions[direction].opposite
    endif
  endfor
enddef

for [k, v] in directions->items()
  for m in v.mappings
    execute $"nnoremap <silent> <c-w>{m} <scriptcmd> NextWindow('{k}', v:count1)<cr>"
  endfor
endfor
