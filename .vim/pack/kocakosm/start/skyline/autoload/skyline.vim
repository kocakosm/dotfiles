scriptencoding utf-8
"----------------------------------------------------------------------"
" skyline.vim                                                          "
" Copyright (c) 2022 Osman Koçak <kocakosm@gmail.com>                  "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:autoloaded_skyline') || (v:version < 802 && !has('nvim-0.7')) || &cp
  finish
endif
let g:autoloaded_skyline = 1

let s:cpo = &cpo
set cpo&vim

let g:qf_disable_statusline = 1

" FIXME: reload theme on Colorscheme event
" TODO: cleanup
" TODO: check and cache config
" TODO: in a given status line, show/hide components depending on winwidth
" TODO: documentation

" config structure:
" let g:skyline = #{
" \  components: #{
" \    <component1_name>: <component_definition>,
" \    <component2_name>: <component_definition>,
" \    ...
" \  },
" \  statuslines: #{
" \    <buftype_or_filetype>: #{
" \      default: [<component_names>]
" \    },
" \    <buftype_or_filetype>: #{
" \      active: [<component_names>],
" \      inactive: [<component_names>]
" \    },
" \    ...
" \  },
" \  themes: #{
" \    <theme_name>: #{
" \      <component1_name>: #{
" \        default: #{<highlight_attributes>}
" \      },
" \      <component2_name>: #{
" \        active: #{
" \          default: #{<highlight_attributes>},
" \          normal: #{<highlight_attributes>},
" \          insert: #{<highlight_attributes>},
" \          ...
" \        },
" \        inactive: #{
" \          default: #{<highlight_attributes>},
" \          ...
" \        }
" \      }
" \      ...
" \    }
" \    ...
" \  }
" \  ...
" \}

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
\  'r'  : 'Prompt',
\  '!'  : 'Shell',
\  't'  : 'Terminal'
\}

let s:cache = #{
\  statuslines: {}
\}

function! skyline#get_statusline() abort
  let mode = mode()
  let active = g:statusline_winid == win_getid()
  let key = printf('%s:%s:%s', g:statusline_winid, active, mode)
  if !(s:cache.statuslines->has_key(key))
    call s:cleanup_cache()
    let s:cache.statuslines[key] = s:build_statusline(g:statusline_winid, active, mode)
  endif
  let statusline = s:cache.statuslines[key]
  execute statusline.highlight_cmd
  return statusline.content
endfunction

function! s:cleanup_cache() abort
  eval s:cache.statuslines->filter({k, _ -> win_id2win(k->split('\:')[0])})
endfunction

function! s:build_statusline(winid, active, mode) abort
  let components = g:->get('skyline', {})->get('components', {})
  let hl_group_suffixes = s:get_hl_group_suffixes(a:active, a:mode)
  let default_hl_group = a:active ? 'StatusLine' : 'StatusLineNC'
  let statusline = ''
  let highlight_cmds = []
  for component in s:get_statusline_components(a:winid, a:active)
    let base_hl_group = 'Skyline' . component
    eval highlight_cmds->add(s:get_component_highlight_cmd(base_hl_group, hl_group_suffixes, default_hl_group))
    let statusline .= printf('%%#%s#%s', base_hl_group, components->get(component, '%(%)'))
  endfor
  return #{content: statusline, highlight_cmd: highlight_cmds->join('|')}
endfunction

function! s:get_statusline_components(winid, active) abort
  let statuslines = g:->get('skyline', {})->get('statuslines', {})
  let statusline = {}
  for ft in s:get_filetypes(a:winid)
    let statusline = statuslines->get(ft, {})
    if !(statusline->empty()) | break | endif
  endfor
  if statusline->empty()
    let statusline = statuslines->get(getwinvar(a:winid, '&buftype'), {})
  endif
  let components = []
  if a:active && statusline->has_key('active')
    let components = statusline.active
  elseif !a:active && statusline->has_key('inactive')
    let components = statusline.inactive
  elseif statusline->has_key('default')
    let components = statusline.default
  endif
  return components
endfunction

function! s:get_filetypes(winid) abort
  let ft = a:winid->getwinvar('&filetype')
  return ft->split('\.')->map({_, s -> s->trim()->tolower()})
endfunction

function! s:get_hl_group_suffixes(active, mode) abort
  let hl_groups = ['Default']
  let hl_group = a:active ? 'Active' : 'Inactive'
  eval hl_groups->add(hl_group . 'Default')
  if s:modes_hl_group_suffix->has_key(a:mode)
    eval hl_groups->add(hl_group . s:modes_hl_group_suffix[a:mode])
  endif
  return hl_groups->reverse()
endfunction

function! s:get_component_highlight_cmd(base_hl_group, hl_group_suffixes, default_hl_group) abort
  for suffix in a:hl_group_suffixes
    let hl = a:base_hl_group . suffix
    if s:hl_group_exists(hl)
      return printf('highlight link %s %s', a:base_hl_group, hl)
    endif
  endfor
  return printf('highlight link %s %s', a:base_hl_group, a:default_hl_group)
endfunction

function! s:hl_group_exists(hl) abort
  return hlexists(a:hl) && execute('highlight ' . a:hl) !~? 'clear'
endfunction

function! skyline#set_theme(name) abort
  call s:clear_cache()
  call s:reset_highlights()
  let theme = s:get_theme(a:name)
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

function! s:clear_cache(...) abort
  if empty(a:000)
    let s:cache.statuslines = {}
  else
    eval s:cache.statuslines->filter({k, _ -> a:000->index(k->split('\:')[0]) >= 0})
  endif
endfunction

function! s:reset_highlights() abort
  execute execute('filter /Skyline/ highlight')->split('\n')
        \ ->map({_, v -> 'highlight clear ' . v->split('\s')[0]})
        \ ->join('|')
endfunction

function! s:get_theme(name) abort
  return g:->get('skyline', {})->get('themes', {})->get(a:name, {})
endfunction

function! s:highlight(group, attributes) abort
  if !empty(a:attributes)
    execute printf('highlight Skyline%s %s', a:group,
          \ a:attributes->items()->map({_, v -> join(v, '=')})->join(' '))
  endif
endfunction

augroup __Skyline__
  autocmd!
  autocmd ColorScheme * call <sid>clear_cache()
  autocmd FileType,BufWinEnter * call <sid>clear_cache(win_getid())
augroup END

let &cpo = s:cpo
unlet! s:cpo
