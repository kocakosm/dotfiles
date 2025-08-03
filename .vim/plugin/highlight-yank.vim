vim9script

def HighlightYank()
  if v:event.operator ==? 'y' && !v:event.visual
    const hlgroup = g:->get('highlight_yank_hlgroup', 'Visual')
    const duration = g:->get('highlight_yank_duration', 225)
    const [beg, end] = [getpos("'["), getpos("']")]
    const type = v:event.regtype ?? 'v'
    const pos = getregionpos(beg, end, {type: type, exclusive: false})
    const m = matchaddpos(hlgroup, pos->mapnew((_, v) => {
      const col_beg = v[0][2] + v[0][3]
      const col_end = v[1][2] + v[1][3] + 1
      return [v[0][1], col_beg, col_end - col_beg]
    }))
    timer_start(duration, (_) => m->matchdelete(win_getid()))
  endif
enddef

augroup __HighlightYank__
  autocmd!
  autocmd TextYankPost * HighlightYank()
augroup END
