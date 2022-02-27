scriptencoding utf-8
"----------------------------------------------------------------------"
" skyline.vim                                                          "
" Copyright (c) 2022 Osman Koçak <kocakosm@gmail.com>                  "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:autoloaded_skyline')
  finish
endif
let g:autoloaded_skyline = 1

let s:cpo = &cpo
set cpo&vim

" TODO: cleanup
" TODO: in a given status line, show/hide components depending on winwidth
" TODO: port to vimscript9 ?

let s:modes_hl_group_suffix = {
\  'n'  : 'Normal',
\  'v'  : 'Visual',
\  'V'  : 'Visual',
\  '' : 'Visual',
\  's'  : 'Select',
\  'S'  : 'Select',
\  '' : 'Select',
\  'i'  : 'Insert',
\  'R'  : 'Replace',
\  'c'  : 'Command',
\  'cv' : 'Ex',
\  'ce' : 'Ex',
\  'r'  : 'Prompt',
\  '!'  : 'Shell',
\  't'  : 'Terminal'
\}

function! skyline#get_statusline() abort
  let bufnr = winbufnr(g:statusline_winid)
  let active = g:statusline_winid == win_getid()
  let filetypes = s:get_filetypes(bufnr)
  let buftype = getbufvar(bufnr, '&buftype')
  let statusline = {}
  for ft in reverse(filetypes)
    let statusline = s:get_statusline_for(ft)
    if !(statusline->empty()) | break | endif
  endfor
  if statusline->empty()
    let statusline = s:get_statusline_for(buftype)
  endif
  let components = []
  if active && statusline->has_key('active')
    let components = statusline.active
  elseif !active && statusline->has_key('inactive')
    let components = statusline.inactive
  elseif statusline->has_key('default')
    let components = statusline.default
  endif
  let mode = mode()
  let sline = ''
  for component in components
    call s:highlight_component(component, active, mode)
    let sline .= '%#Skyline' . component . '#' . get(g:, 'skyline', {})->get('components', {})->get(component, '%(%)')
  endfor
  return sline
endfunction

function! s:get_statusline_for(type) abort
  return get(g:, 'skyline', {})->get('statuslines', {})->get(a:type, {})
endfunction

function! s:get_filetypes(bufnr) abort
  let ft = getbufvar(a:bufnr, '&filetype')
  return ft->split('\.')->map({_, s -> tolower(trim(s))})
endfunction

function! s:highlight_component(component, active, mode) abort
  execute 'highlight link Skyline' . a:component . ' '
        \ . s:get_component_highlight(a:component, a:active, a:mode)
endfunction

function! s:get_component_highlight(component, active, mode) abort
  let hl_groups = [a:active ? 'StatusLine' : 'StatusLineNC']
  let hl_group = 'Skyline' . a:component
  call add(hl_groups, hl_group . 'Default')
  let hl_group .= a:active ? 'Active' : 'Inactive'
  call add(hl_groups, hl_group . 'Default')
  if s:modes_hl_group_suffix->has_key(a:mode)
    let hl_group .= s:modes_hl_group_suffix[a:mode]
    call add(hl_groups, hl_group)
  endif
  for hl in reverse(hl_groups)
    if s:hl_group_exists(hl) | return hl | endif
  endfor
endfunction

function! s:hl_group_exists(hl) abort
  return hlexists(a:hl) && execute('highlight ' . a:hl) !~? 'clear'
endfunction

" structure:
" let g:skyline = #{
" \  ...
" \  themes: #{
" \    default: #{...}
" \    <colorscheme_name>: #{
" \      <component_name>: #{
" \        default: #{<highlight_attributes>},
" \        active: #{
" \          default: #{<highlight_attributes>},
" \          normal: #{<highlight_attributes>},
" \          insert: #{<highlight_attributes>}
" \        }
" \      }
" \    }
" \  }
" \  ...
" \}
function! skyline#set_theme(colorscheme) abort
  let themes = get(g:, 'skyline', {})->get('themes', {})
  let theme = themes->get(a:colorscheme, {})
  if theme->empty()
    let theme = themes->get('default', {})
  endif
  for component in theme->keys()
    for status in theme[component]->keys()
      if status ==? 'default'
        call s:highlight(component . status, theme[component][status])
      else
        for mode in theme[component][status]->keys()
          call s:highlight(component . status . mode, theme[component][status][mode])
        endfor
      endif
    endfor
  endfor
endfunction

function! s:highlight(group, attributes) abort
  if !a:attributes->empty()
    let cmd = 'highlight Skyline' . a:group
    for attribute in a:attributes->keys()
      let cmd .= ' ' . attribute . '=' . a:attributes[attribute]
    endfor
    execute cmd
  endif
endfunction

let &cpo = s:cpo
unlet! s:cpo
