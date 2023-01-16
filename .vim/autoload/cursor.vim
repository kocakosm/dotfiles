vim9script

var t_ve_save: string = &t_ve
var guicursor_save: string = &guicursor

export def Hide(): void
  if has('gui_running')
    noautocmd &guicursor = 'a:xxx'
  else
    noautocmd &t_ve = ''
  endif
enddef

export def Show(): void
  if has('gui_running')
    noautocmd &guicursor = guicursor_save
  else
    noautocmd &t_ve = t_ve_save
  endif
enddef

augroup CursorChanged
  autocmd!
  autocmd OptionSet t_ve t_ve_save = v:option_new
  autocmd OptionSet guicursor guicursor_save = v:option_new
augroup END
