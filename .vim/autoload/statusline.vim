let s:modes = {
\  'n'  : 'NORMAL',
\  'v'  : 'VISUAL',
\  'V'  : 'V·LINE',
\  '' : 'V·BLOCK',
\  's'  : 'SELECT',
\  'S'  : 'S·LINE',
\  '' : 'S·BLOCK',
\  'i'  : 'INSERT',
\  'R'  : 'REPLACE',
\  'c'  : 'COMMAND',
\  'r'  : 'PROMPT',
\  '!'  : 'SHELL',
\  't'  : 'TERMINAL'
\}

function! statusline#mode() abort
  return get(s:modes, mode(), '')
endfunction

function! statusline#git_head() abort
  let h = git#head()
  return empty(h) ? '' : ' ' . h
endfunction

function! statusline#filename() abort
  let filename = expand('%:t')
  return empty(filename) ? '[New]' : filename
endfunction

function! statusline#file_info() abort
  return ((&readonly || !&modifiable) ? ' ' : '')
        \ . statusline#filename() . (&modified ? ' ∙' : '')
endfunction

function! statusline#type() abort
  if &buftype ==# 'quickfix'
    return s:is_location_list(win_getid()) ? 'Location List' : 'Quickfix'
  elseif index(['help', 'terminal'], &buftype) > -1
    return string#capitalize(&buftype)
  elseif !empty(&buftype)
    return string#capitalize(&filetype)
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
  return win_gettype(a:winid) ==# 'loclist'
endfunction

function! statusline#file_type() abort
  return tolower(&filetype)
endfunction

function! statusline#file_format_and_encoding() abort
  return &fileformat . ' ' . (empty(&fileencoding) ? &encoding : &fileencoding)
endfunction

function! statusline#search_count() abort
  if v:hlsearch
    try
      let c = searchcount(#{maxcount: 0})
      if !empty(c)
        let searched = string#abbreviate(@/, 16, '...')
        return printf('/%s [%s/%s]', searched, c.current, c.incomplete ? '??' : c.total)
      endif
    catch
    endtry
  endif
  return ''
endfunction

function! statusline#spell_lang() abort
  return &spell ? toupper(&spelllang) : ''
endfunction
