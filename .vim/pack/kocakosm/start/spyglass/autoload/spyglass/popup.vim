vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# spyglass/popup.vim                                                   #
# Copyright (c) 2023 Osman Koçak <kocakosm@gmail.com>                  #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:autoloaded_spyglass_popup') || &cp
  finish
endif
g:autoloaded_spyglass_popup = 1

import autoload './actions.vim'

const BORDER_CHARS: list<string> = ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
const PADDING: list<number> = [0, 1, 0, 1]
const DEFAULT_MAPPINGS: dict<string> = {
  "\<CR>": actions.CONFIRM,
  "\<C-y>": actions.CONFIRM,
  "\<Esc>": actions.CANCEL,
  "\<C-e>": actions.CANCEL,
  "\<PageUp>": actions.PAGE_UP,
  "\<PageDown>": actions.PAGE_DOWN,
  "\<Home>": actions.HOME,
  "\<End>": actions.END,
  "\<Down>": actions.DOWN,
  "\<Tab>": actions.DOWN,
  "\<C-n>": actions.DOWN,
  "\<Up>": actions.UP,
  "\<S-Tab>": actions.UP,
  "\<C-p>": actions.UP,
  "\<C-u>": actions.CLEAR_FILTER,
  "\<C-h>": actions.FILTER_POP,
  "\<BS>": actions.FILTER_POP
}

highlight default link SpyglassPopup Normal
highlight default link SpyglassPopupBorder Normal
highlight default link SpyglassPopupBorderTop SpyglassPopupBorder
highlight default link SpyglassPopupBorderRight SpyglassPopupBorder
highlight default link SpyglassPopupBorderBottom SpyglassPopupBorder
highlight default link SpyglassPopupBorderLeft SpyglassPopupBorder
highlight default link SpyglassFilterMatch Constant
highlight default link SpyglassCurrentItem Statement

if prop_type_get('SpyglassFilterMatch')->empty()
  const options = {
    highlight: 'SpyglassFilterMatch',
    priority: 1000, override: true, combine: true
  }
  prop_type_add('SpyglassFilterMatch', options)
endif

export def Create(title: string, items: list<any>,
                  OnSelect: func(any, string),
                  current_item: string = '',
                  mappings: dict<string> = {},
                  OnAbort: func() = null_function): number
  silent doautocmd User SpyglassOpen
  const key_mappings = DEFAULT_MAPPINGS->extendnew(mappings)
  const raw_items = FormatItems(items)
  var filter = ''
  var filtered_items: list<any> = Filter(raw_items, filter)
  const content = GetPopupContent(filter, filtered_items)
  const width = ComputePopupWidth(title, raw_items)
  const header_width = width + PADDING[1] + PADDING[3]
  const popup_options = {
    title: GetPopupHeader(title, filter, filtered_items[0]->len(), raw_items->len(), header_width),
    line: 1,
    minwidth: width,
    maxwidth: width,
    maxheight: &lines - &cmdheight - 3 - PADDING[0] - PADDING[2], # 3: borders + statusline
    border: [],
    borderchars: BORDER_CHARS,
    borderhighlight: [
      'SpyglassPopupBorderTop', 'SpyglassPopupBorderRight',
      'SpyglassPopupBorderBottom', 'SpyglassPopupBorderLeft'
    ],
    highlight: 'SpyglassPopup',
    padding: PADDING,
    mapping: false,
    scrollbar: false,
    filter: (winid, key) => {
      const action = key_mappings->get(key, actions.FILTER_PUSH)
      if action == actions.CANCEL
        silent doautocmd User SpyglassClose
        popup_close(winid)
        if OnAbort != null_function | OnAbort() | endif
      elseif action == actions.CONFIRM && filtered_items[0]->len() > 0
        silent doautocmd User SpyglassClose
        const selected_item_index = line('.', winid) - 1
        popup_close(winid)
        OnSelect(filtered_items[0][selected_item_index], key)
      elseif action == actions.PAGE_DOWN
        win_execute(winid, "normal! \<C-d>")
      elseif action == actions.PAGE_UP
        win_execute(winid, "normal! \<C-u>")
      elseif action == actions.HOME
        win_execute(winid, 'normal! gg')
      elseif action == actions.END
        win_execute(winid, 'normal! G')
      elseif action == actions.DOWN
        if line('.', winid) == line('$', winid)
          win_execute(winid, 'normal! gg')
        else
          win_execute(winid, 'normal! j')
        endif
      elseif action == actions.UP
        if line('.', winid) == 1
          win_execute(winid, 'normal! G')
        else
          win_execute(winid, 'normal! k')
        endif
      elseif action == actions.CLEAR_FILTER
        filter = ''
        filtered_items = Filter(raw_items, filter)
        UpdatePopup(winid, title, filter, raw_items, filtered_items, header_width)
      elseif action == actions.FILTER_POP
        filter = filter->strcharpart(0, filter->strchars() - 1)
        filtered_items = Filter(raw_items, filter)
        UpdatePopup(winid, title, filter, raw_items, filtered_items, header_width)
      elseif action == actions.FILTER_PUSH && key =~ '^\p$'
        filter ..= key
        filtered_items = Filter(raw_items, filter)
        UpdatePopup(winid, title, filter, raw_items, filtered_items, header_width)
      endif
      return true
    }
  }
  const winid = popup_create(content, popup_options)
  if !items->empty()
    win_execute(winid, 'setlocal cursorline cursorlineopt=both')
    HighlightCurrentItem(winid, current_item)
  endif
  return winid
enddef

def FormatItems(items: list<any>): list<dict<any>>
  return items->mapnew(
    (i, item) => {
      const type = item->type()
      if type == v:t_string
        return {text: item}
      elseif type == v:t_dict && item->has_key('text')
        return item
      endif
      Warn('Invalid input at index ' .. i)
      return {}
    }
  )->filter((_, item) => !item->empty())
enddef

def Warn(msg: string): void
  echohl WarningMsg | echomsg '[spyglass]' msg | echohl None
enddef

def ComputePopupWidth(title: string, raw_items: list<dict<any>>): number
  const content_width = raw_items->mapnew((_, i) => i.text->strchars())->max()
  const width = title->strchars() + $'{raw_items->len()}'->strchars() * 2 + content_width / 2 + 10
  const min_width = max([content_width, (&columns * 0.5)->float2nr()])
  const max_width = &columns - 2 - PADDING[1] - PADDING[3] # 2: popup borders
  return min([max([width, min_width]), max_width])
enddef

def GetPopupHeader(title: string, filter: string,
                   filtered_items_count: number, raw_items_count: number,
                   length: number): string
  const head = $' {title} '
  const head_len = head->strchars()
  const tail = $' {filtered_items_count}/{raw_items_count} '
  const tail_len = tail->strchars()
  if filter->empty()
    const separator_len = length - head_len - tail_len
    return head .. repeat(BORDER_CHARS[0], separator_len) .. tail
  else
    const middle = $' 🔎︎ {filter} '
    const middle_len = middle->strchars()
    const separator1_len = max([((length - middle_len) / 2) - head_len, 2])
    const separator2_len = max([length - middle_len - separator1_len - head_len - tail_len, 2])
    return head .. repeat(BORDER_CHARS[0], separator1_len) ..
           middle .. repeat(BORDER_CHARS[0], separator2_len) .. tail
  endif
enddef

def GetPopupContent(filter: string, filtered_items: list<any>): list<any>
  return filtered_items[0]->mapnew((i, v) => {
    return {text: v.text, props: filtered_items[1][i]->mapnew((_, c) => {
      return {col: v.text->byteidx(c) + 1, length: 1, type: 'SpyglassFilterMatch'}
    })}
  })
enddef

def Filter(raw_items: list<dict<any>>, filter: string): list<any>
  if filter->empty()
    return [raw_items, raw_items->mapnew((_, _) => []), []]
  endif
  return raw_items->matchfuzzypos(filter, {key: 'text'})
enddef

def UpdatePopup(winid: number, title: string, filter: string,
                raw_items: list<dict<any>>, filtered_items: list<any>,
                header_width: number): void
  const header = GetPopupHeader(title, filter, filtered_items[0]->len(),
                                raw_items->len(), header_width)
  const content = GetPopupContent(filter, filtered_items)
  if content->empty()
    win_execute(winid, 'setlocal nocursorline')
  else
    win_execute(winid, 'setlocal cursorline')
  endif
  popup_settext(winid, content)
  popup_setoptions(winid, {title: header})
  win_execute(winid, 'normal! gg')
enddef

def HighlightCurrentItem(winid: number, current_item: string): void
  const regex = '^\V' .. current_item->escape('\/?') .. '\$'
  win_execute(winid, $'syntax match SpyglassCurrentItem "{regex}"')
enddef
