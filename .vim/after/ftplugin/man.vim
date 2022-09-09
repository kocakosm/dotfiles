nnoremap <silent> <buffer> <up> <c-y>
nnoremap <silent> <buffer> <down> <c-e>
nnoremap <silent> <buffer> k <c-y>
nnoremap <silent> <buffer> j <c-e>
nnoremap <silent> <buffer> w <nop>
nnoremap <silent> <buffer> W <nop>
nnoremap <silent> <buffer> b <nop>
nnoremap <silent> <buffer> B <nop>
nnoremap <silent> <buffer> e <nop>
nnoremap <silent> <buffer> E <nop>
nnoremap <silent> <buffer> ge <nop>
nnoremap <silent> <buffer> gE <nop>
nnoremap <silent> <buffer> <s-left> <nop>
nnoremap <silent> <buffer> <s-right> <nop>
nnoremap <silent> <buffer> <c-left> <nop>
nnoremap <silent> <buffer> <c-right> <nop>

setlocal whichwrap=

augroup __Man__
  autocmd! * <buffer>
  autocmd CursorMoved <buffer> call cursor(line('.'), 1)
augroup END

call ftplugin#append_undo_cmd('setlocal whichwrap< | autocmd! __Man__')

execute '0file | file ' . substitute(expand('%:t'), '\.\~$', '', '')
