vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# skyline.vim                                                          #
# Copyright (c) 2022-2023 Osman Koçak <kocakosm@gmail.com>             #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:autoloaded_skyline') || v:version < 900 || &cp
  finish
endif
g:autoloaded_skyline = 1

g:statusline_winid = 1000

highlight default link Skyline StatusLine
highlight default link SkylineNC StatusLineNC

# TODO: in a given status line, show/hide components depending on winwidth

# config structure:
# g:skyline = #{
#   components: #{
#     <component1_name>: <component_definition>,
#     <component2_name>: <component_definition>,
#     ...
#   },
#   statuslines: #{
#     <buftype_or_filetype>: #{
#       default: [<component_names>]
#     },
#     <buftype_or_filetype>: #{
#       active: [<component_names>],
#       inactive: [<component_names>]
#     },
#     ...
#   }
# }

final cache: dict<string> = {}

export def StatusLine(): string
  const active = g:statusline_winid == win_getid()
  const key = $'{g:statusline_winid}:{active}'
  if !cache->has_key(key)
    CleanupCache()
    cache[key] = BuildStatusLine(g:statusline_winid, active)
  endif
  return cache[key]
enddef

def CleanupCache(): void
  cache->filter((k, _) => WinExists(str2nr(k->split('\:')[0])))
enddef

def WinExists(winid: number): bool
  return win_id2win(winid) > 0
enddef

def BuildStatusLine(winid: number, active: bool): string
  const components = GetComponentDefinitions()
  const statusline = GetStatusLineComponents(winid, active)
                      ->mapnew((_, c) => components->get(c, '%(%)'))
                      ->join('')
  return printf('%%#%s#%s', active ? 'Skyline' : 'SkylineNC', statusline)
enddef

def GetStatusLineComponents(winid: number, active: bool): list<string>
  const statusline_definitions = GetStatusLineDefinitions()
  var statusline: dict<list<string>> = {}
  for ft in GetFileTypes(winid)
    if statusline_definitions->has_key(ft)
      statusline = statusline_definitions->get(ft)
      break
    endif
  endfor
  if statusline->empty()
    statusline = statusline_definitions->get(getwinvar(winid, '&buftype'), {})
  endif
  var components: list<string> = []
  if active && statusline->has_key('active')
    components = statusline.active
  elseif !active && statusline->has_key('inactive')
    components = statusline.inactive
  elseif statusline->has_key('default')
    components = statusline.default
  endif
  return components
enddef

def GetComponentDefinitions(): dict<string>
  return g:->get('skyline', {})->get('components', {})
enddef

def GetStatusLineDefinitions(): dict<dict<list<string>>>
  return g:->get('skyline', {})->get('statuslines', {})
enddef

def GetFileTypes(winid: number): list<string>
  const ft = getwinvar(winid, '&filetype')
  return ft->split('\.')->map((_, s) => s->trim()->tolower())
enddef

def ClearCache(winid: number): void
  cache->filter((k, _) => str2nr(k->split('\:')[0]) != winid)
enddef

augroup __Skyline__
  autocmd!
  autocmd FileType,BufWinEnter * ClearCache(win_getid())
augroup END
