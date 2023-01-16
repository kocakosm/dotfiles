" Better format for quickfix/location list items
function! s:format_quickfix(info) abort
  let items = a:info.quickfix
        \ ? getqflist({'id': a:info.id, 'items': 1}).items
        \ : getloclist(a:info.winid, {'id': a:info.id, 'items': 1}).items
  let fmt = '%S:%S ∙ %S'
  return items[a:info.start_idx - 1 : a:info.end_idx - 1]
        \ ->map({_, i -> printf(fmt, bufname(i.bufnr), i.lnum, trim(i.text))})
endfunction

let &quickfixtextfunc = expand('<SID>') . 'format_quickfix'

" Commands that trigger a QuickFixCmdPost event
let s:qf_cmds = [
\  'make', 'grep', 'grepadd', 'vimgrep', 'vimgrepadd', 'helpgrep', 'cfile',
\  'cgetfile', 'caddfile', 'cexpr', 'cgetexpr', 'caddexpr', 'cbuffer',
\  'cgetbuffer', 'caddbuffer'
\]

function! s:quickfix_cmds() abort
  return s:qf_cmds->join(',')
endfunction

function! s:loclist_cmds() abort
  return s:qf_cmds->map({_, c -> 'l' . (c[0] ==# 'c' ? c[1:] : c)})->join(',')
endfunction

augroup Quickfix
  autocmd!
  " Automatically open the location/quickfix window
  execute 'autocmd QuickFixCmdPost ' . s:quickfix_cmds() .
        \ " nested call async#execute('cwindow | doautocmd BufEnter')"
  execute 'autocmd QuickFixCmdPost ' . s:loclist_cmds() .
        \ " nested call async#execute('silent! lwindow | doautocmd BufEnter')"
  autocmd VimEnter * nested if count(v:argv, '-q') | cwindow | endif
  " Close the corresponding location list when quitting a window
  autocmd QuitPre * nested if &filetype != 'qf' | silent! lclose | endif
augroup END
