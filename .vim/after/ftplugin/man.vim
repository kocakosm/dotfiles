const s:mappings = {
\  '<home>' : 'gg',
\  '<end>' : 'G',
\  '<up>' : '<c-y>',
\  '<down>' : '<c-e>',
\  '<c-up>' : '<c-y>',
\  '<c-down>' : '<c-e>',
\  '<cr>' : '<c-e>',
\  '<space>' : '<c-f>',
\  'f' : '<c-f>',
\  'b' : '<c-b>',
\  '<left>' : '<nop>',
\  '<right>' : '<nop>',
\  'd' : '<c-d>',
\  'u' : '<c-u>',
\  'k' : '<c-y>',
\  'j' : '<c-e>',
\  'gk' : '<c-y>',
\  'gj' : '<c-e>',
\  'h' : '<nop>',
\  'l' : '<nop>',
\  '0' : '<nop>',
\  '^' : '<nop>',
\  '$' : '<nop>',
\  'g0' : '<nop>',
\  'g^' : '<nop>',
\  'g$' : '<nop>',
\  'w' : '<nop>',
\  'W' : '<nop>',
\  'B' : '<nop>',
\  'e' : '<nop>',
\  'E' : '<nop>',
\  'ge' : '<nop>',
\  'gE' : '<nop>',
\  'zt' : '<nop>',
\  'zz' : '<nop>',
\  'zb' : '<nop>',
\  'zh' : '<nop>',
\  'zl' : '<nop>',
\  'zH' : '<nop>',
\  'zL' : '<nop>',
\  '<s-left>' : '<nop>',
\  '<s-right>' : '<nop>',
\  '<c-left>' : '<nop>',
\  '<c-right>' : '<nop>',
\}

for [lhs, rhs] in s:mappings->items()
  execute $'nnoremap <silent> <buffer> {lhs} {rhs}'
  call ftplugin#append_undo_cmd($'nunmap <buffer> {lhs}')
endfor

let name = expand('%:t')
let parts = matchlist(name, '\(^[a-zA-Z0-9]*\)[\.\(]\(\d*\)[\.\)\~]')
if !parts->empty()
  let name = printf('%s(%s)', parts[1], parts[2]->empty() ? '1' : parts[2])
endif
if bufexists(name) | execute 'bwipeout ' . name | endif
execute '0file | file ' . name . ' | bwipeout #'

setlocal nocursorline colorcolumn=
call ftplugin#append_undo_cmd('setlocal cursorline< colorcolumn<')
