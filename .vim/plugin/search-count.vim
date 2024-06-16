vim9script

highlight default link SearchCount MoreMsg
highlight default link SearchCountBorder MoreMsg

final popup = {
  id: popup_create('', {
    hidden: true,
    pos: 'topright',
    border: [],
    padding: [0, 1, 0, 1],
    highlight: 'SearchCount',
    borderhighlight: ['SearchCountBorder'],
    borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
  }),
  visible: false
}

def UpdatePopup(): void
  if v:hlsearch
    const search_count = searchcount({maxcount: 0})
    if search_count.current > 0
      const win = getwininfo(win_getid())[0]
      const max_width = win.width - win.textoff - 5
      if win.height >= 3 && max_width >= 6
        const text = string#Abbreviate(
          printf(
            '%s [%s/%s]', @/,
            search_count.incomplete ? '?' : search_count.current,
            search_count.incomplete ? '??' : search_count.total
          ),
          max_width, '...'
        )
        const width = text->len()
        popup_settext(popup.id, text)
        popup_move(popup.id, {
          line: win.winrow,
          col: win.wincol + win.width - 2,
          minwidth: width,
          maxwidth: width
        })
        ShowPopup()
        return
      endif
    endif
  endif
  HidePopup()
enddef

def ShowPopup(): void
  if !popup.visible
    popup_show(popup.id)
    popup.visible = true
  endif
enddef

def HidePopup(): void
  if popup.visible
    silent! popup_hide(popup.id)
    popup.visible = false
  endif
enddef

augroup __SearchCount__ | autocmd! | augroup END

def SearchCount(hlsearch: bool): void
  autocmd! __SearchCount__ SafeState,VimResized
  if hlsearch
    autocmd __SearchCount__ SafeState,VimResized * UpdatePopup()
  else
    HidePopup()
  endif
enddef

autocmd __SearchCount__ OptionSet hlsearch SearchCount(v:option_new == '1')

SearchCount(&hlsearch)
