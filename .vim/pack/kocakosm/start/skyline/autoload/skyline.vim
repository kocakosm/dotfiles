vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# skyline.vim                                                          #
# Copyright (c) 2022 Osman Koçak <kocakosm@gmail.com>                  #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:autoloaded_skyline') || v:version < 900 || &cp
  finish
endif
g:autoloaded_skyline = 1

g:statusline_winid = 1000

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

final statuslines_cache: dict<string> = {}

export def StatusLine(): string
  const active = g:statusline_winid == win_getid()
  const id = printf('%s:%s', g:statusline_winid, active)
  if !statuslines_cache->has_key(id)
    CleanupStatusLinesCache()
    statuslines_cache[id] = BuildStatusLine(g:statusline_winid, active)
  endif
  return statuslines_cache[id]
enddef

def CleanupStatusLinesCache(): void
  statuslines_cache->filter((k, _) => win_id2win(str2nr(k->split('\:')[0])) > 0)
enddef

def BuildStatusLine(winid: number, active: bool): string
  const definitions = g:->get('skyline', {})->get('components', {})
  return GetStatusLineComponents(winid, active)
           ->mapnew((_, c) => definitions->get(c, '%(%)'))->join('')
enddef

def GetStatusLineComponents(winid: number, active: bool): list<string>
  const statuslines = g:->get('skyline', {})->get('statuslines', {})
  var statusline: dict<list<string>> = {}
  for ft in GetFileTypes(winid)
    statusline = statuslines->get(ft, {})
    if !statusline->empty() | break | endif
  endfor
  if statusline->empty()
    statusline = statuslines->get(winid->getwinvar('&buftype'), {})
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

def GetFileTypes(winid: number): list<string>
  const ft = winid->getwinvar('&filetype')
  return ft->split('\.')->map((_, s) => s->trim()->tolower())
enddef

def ClearStatusLinesCache(win: number): void
  statuslines_cache->filter((k, _) => str2nr(k->split('\:')[0]) != win)
enddef

augroup __Skyline__
  autocmd!
  autocmd FileType,BufWinEnter * ClearStatusLinesCache(win_getid())
augroup END
