vim9script

# requires 'hlsearch' to be set

const POPUP_ID = popup_create('', {hidden: true})

highlight default link SearchCountPopup MoreMsg
highlight default link SearchCountPopupBorder MoreMsg

def UpdatePopup(): void
  if v:hlsearch
    const search_count = searchcount({maxcount: 0})
    if search_count.current > 0
      ShowPopup(
        printf(
          '%s [%s/%s]',
          string#Abbreviate(@/, 16, '...'),
          search_count.current,
          search_count.incomplete ? '??' : search_count.total
        )
      )
      return
    endif
  endif
  HidePopup()
enddef

def ShowPopup(text: string): void
  const win = getwininfo(win_getid())[0]
  const options = {
    pos: 'topright',
    line: win.winrow,
    col: win.wincol + win.width - 2,
    minwidth: text->len(),
    maxwidth: text->len(),
    border: [],
    padding: [0, 1, 0, 1],
    highlight: 'SearchCountPopup',
    borderhighlight: ['SearchCountPopupBorder'],
    borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
  }
  popup_settext(POPUP_ID, text)
  popup_setoptions(POPUP_ID, options)
  popup_show(POPUP_ID)
enddef

def HidePopup(): void
  popup_hide(POPUP_ID)
enddef

augroup __SearchCountPopup__ | autocmd! | augroup END

def SearchCountPopup(hlsearch: bool): void
  autocmd! __SearchCountPopup__ SafeState,VimResized
  if hlsearch
    autocmd __SearchCountPopup__ SafeState,VimResized * UpdatePopup()
  else
    HidePopup()
  endif
enddef

autocmd __SearchCountPopup__ OptionSet hlsearch SearchCountPopup(v:option_new == '1')

SearchCountPopup(&hlsearch)
