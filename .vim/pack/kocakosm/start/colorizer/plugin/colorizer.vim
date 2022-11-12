vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# colorizer.vim                                                        #
# Displays color using virtual text                                    #
# Copyright (c) 2022 Osman Koçak <kocakosm@gmail.com>                  #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

# TODO: support css' rgb(...), rgba(...), hsl(...), color name and short hex formats

if exists('g:loaded_colorizer') || !has('patch-9.0.0534') || &cp || !(has('gui_running') || &termguicolors)
  finish
endif
g:loaded_colorizer = 1

def GetVisibleRange(winid: number): list<number>
  var wininfo = getwininfo(winid)[0]
  return [wininfo.topline, wininfo.botline]
enddef

def RefreshWindow(winid: number, lines: list<number> = GetVisibleRange(winid)): void
  const bufnr = winbufnr(winid)
  final prop_types = getbufvar(bufnr, 'colorizer_prop_types', {})
  if !getbufvar(bufnr, 'colorizer_enabled', false)
    if !prop_types->empty()
      prop_remove({types: prop_types->keys(), all: true, bufnr: bufnr})
      setbufvar(bufnr, 'prop_types', {})
    endif
    return
  endif
  if lines[0] < 1 | lines[0] = 1 | endif
  if lines[1] < 1 | lines[1] = 1 | endif
  if !prop_types->empty()
    prop_remove({types: prop_types->keys(), all: true, bufnr: bufnr}, lines[0], lines[1])
  endif
  const color_regex = '#\%(\x\{6}\)\>'
  const badge = g:->get('colorizer_badge', '⏹')
  for linenr in range(lines[0], lines[1])
    const line = getbufline(bufnr, linenr)->get(0, '')
    if line->empty() | continue | endif
    var [color_expr, start, end] = line->matchstrpos(color_regex, 0)
    while start != -1
      const prop_type = 'colorizer_' .. color_expr[1 : ]
      const hl = hlget(prop_type)
      if hl->empty() || hl[0]->has_key('cleared')
        hlset([{name: prop_type, guifg: color_expr}])
      endif
      if !prop_types->has_key(prop_type)
        prop_types[prop_type] = 1
        prop_type_add(prop_type, {highlight: prop_type})
      endif
      prop_add(linenr, start + 1, {text: badge, type: prop_type, bufnr: bufnr})
      [color_expr, start, end] = line->matchstrpos(color_regex, end + 1)
    endwhile
  endfor
  setbufvar(bufnr, 'colorizer_prop_types', prop_types)
enddef

def RefreshAllWindows(): void
  for w in getwininfo()
    RefreshWindow(w.winid)
  endfor
enddef

augroup __Colorizer__ | autocmd! | augroup END

def Disable(): void
  autocmd! __Colorizer__
  b:colorizer_enabled = false
  RefreshAllWindows()
enddef

def Enable(): void
  autocmd! __Colorizer__
  autocmd __Colorizer__ OptionSet background,termguicolors RefreshAllWindows()
  autocmd __Colorizer__ Colorscheme * RefreshAllWindows()
  autocmd __Colorizer__ WinScrolled * RefreshWindow(win_getid())
  autocmd __Colorizer__ BufRead * RefreshWindow(win_getid())
  autocmd __Colorizer__ TextChanged * {
    RefreshWindow(win_getid(), [line("'["), line("']")])
  }
  autocmd __Colorizer__ TextChangedI * {
    const winid = win_getid()
    RefreshWindow(winid, [line('.'), line('.')])
    RefreshWindow(winid, [line("'["), line("']")])
  }
  b:colorizer_enabled = true
  RefreshAllWindows()
enddef

command! -bar ColorizerOn Enable()
command! -bar ColorizerOff Disable()
