vim9script

def HighlightYank(hlgroup = 'Visual', duration = 225)
  if v:event.operator ==? 'y' && !v:event.visual
    const [beg, end] = [getpos("'["), getpos("']")]
    const type = v:event.regtype ?? 'v'
    const pos = getregionpos(beg, end, {type: type})
    const end_offset = (type == 'V' || v:event.inclusive) ? 1 : 0
    const m = matchaddpos(hlgroup, pos->mapnew((_, v) => {
      const col_beg = v[0][2] + v[0][3]
      const col_end = v[1][2] + v[1][3] + end_offset
      return [v[0][1], col_beg, col_end - col_beg]
    }))
    timer_start(duration, (_) => m->matchdelete(win_getid()))
  endif
enddef

augroup __HighlightYank__
  autocmd!
  autocmd TextYankPost * HighlightYank()
augroup END
