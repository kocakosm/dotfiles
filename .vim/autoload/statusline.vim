let s:modes = {
\  'n'    : 'NORMAL',
\  'no'   : 'N·OPERATOR PENDING',
\  'nov'  : 'N·OPERATOR PENDING',
\  'noV'  : 'N·OPERATOR PENDING',
\  'no' : 'N·OPERATOR PENDING',
\  'v'    : 'VISUAL',
\  'V'    : 'V·LINE',
\  ''   : 'V·BLOCK',
\  's'    : 'SELECT',
\  'S'    : 'S·LINE',
\  ''   : 'S·BLOCK',
\  'i'    : 'INSERT',
\  'ic'   : 'INSERT·COMPL',
\  'ix'   : 'INSERT·COMPL',
\  'R'    : 'REPLACE',
\  'Rv'   : 'V·REPLACE',
\  'Rx'   : 'REPLACE·COMPL',
\  'c'    : 'COMMAND',
\  'cv'   : 'EX',
\  'ce'   : 'EX',
\  'r'    : 'PROMPT',
\  'rm'   : 'MORE',
\  'r?'   : 'CONFIRM',
\  '!'    : 'SHELL',
\  't'    : 'TERMINAL'
\}

function! statusline#mode() abort
  return get(s:modes, mode(1), get(s:modes, mode(0), ''))
endfunction

function! statusline#git_head() abort
  let h = git#head()
  return empty(h) ? '' : ' ' . h
endfunction

function! statusline#filename() abort
  return expand('%') ==# '' ? '[New]' : expand('%:t')
endfunction

function! statusline#file_info() abort
  return ((&readonly || !&modifiable) ? ' ' : '')
        \ . statusline#filename() . (&modified ? ' ∙' : '')
endfunction

function! statusline#type() abort
  if &buftype ==# 'quickfix'
    return s:is_location_list(win_getid()) ? 'LOCATION LIST' : 'QUICKFIX'
  elseif index(['help', 'terminal', 'prompt'], &buftype) > -1
    return toupper(&buftype)
  elseif &buftype ==# 'nofile'
    return toupper(&filetype)
  endif
  return ''
endfunction

function! statusline#qf_title() abort
  if s:is_location_list(win_getid())
    return getloclist(0, #{title: 1}).title
  endif
  return getqflist(#{title: 1}).title
endfunction

function! s:is_location_list(winid) abort
  return getwininfo(a:winid)[0].loclist
endfunction

function! statusline#file_type() abort
  return tolower(&filetype)
endfunction

function! statusline#file_encoding() abort
  return
endfunction

function! statusline#file_format_and_encoding() abort
  return &fileformat . ' ' . (&fileencoding !=# '' ? &fileencoding : &encoding)
endfunction

function! statusline#search_count() abort
  if v:hlsearch
    let c = searchcount(#{maxcount: 0})
    if !empty(c)
      return printf('/%s [%s/%s]', @/, c.current, c.incomplete ? '??' : c.total)
    endif
  endif
  return ''
endfunction
