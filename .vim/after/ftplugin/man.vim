nnoremap <silent> <buffer> <home> gg
nnoremap <silent> <buffer> <end> G
nnoremap <silent> <buffer> <up> <c-y>
nnoremap <silent> <buffer> <down> <c-e>
nnoremap <silent> <buffer> <c-up> <c-y>
nnoremap <silent> <buffer> <c-down> <c-e>
nnoremap <silent> <buffer> <cr> <c-e>
nnoremap <silent> <buffer> <space> <c-f>
nnoremap <silent> <buffer> f <c-f>
nnoremap <silent> <buffer> b <c-b>
nnoremap <silent> <buffer> <left> <nop>
nnoremap <silent> <buffer> <right> <nop>
nnoremap <silent> <buffer> d <c-d>
nnoremap <silent> <buffer> u <c-u>
nnoremap <silent> <buffer> k <c-y>
nnoremap <silent> <buffer> j <c-e>
nnoremap <silent> <buffer> gk <c-y>
nnoremap <silent> <buffer> gj <c-e>
nnoremap <silent> <buffer> h <nop>
nnoremap <silent> <buffer> l <nop>
nnoremap <silent> <buffer> 0 <nop>
nnoremap <silent> <buffer> ^ <nop>
nnoremap <silent> <buffer> $ <nop>
nnoremap <silent> <buffer> g0 <nop>
nnoremap <silent> <buffer> g^ <nop>
nnoremap <silent> <buffer> g$ <nop>
nnoremap <silent> <buffer> w <nop>
nnoremap <silent> <buffer> W <nop>
nnoremap <silent> <buffer> B <nop>
nnoremap <silent> <buffer> e <nop>
nnoremap <silent> <buffer> E <nop>
nnoremap <silent> <buffer> ge <nop>
nnoremap <silent> <buffer> gE <nop>
nnoremap <silent> <buffer> zt <nop>
nnoremap <silent> <buffer> zz <nop>
nnoremap <silent> <buffer> zb <nop>
nnoremap <silent> <buffer> zh <nop>
nnoremap <silent> <buffer> zl <nop>
nnoremap <silent> <buffer> zH <nop>
nnoremap <silent> <buffer> zL <nop>
nnoremap <silent> <buffer> <s-left> <nop>
nnoremap <silent> <buffer> <s-right> <nop>
nnoremap <silent> <buffer> <c-left> <nop>
nnoremap <silent> <buffer> <c-right> <nop>

let name = expand('%:t')
let parts = matchlist(name, '\(^[a-zA-Z0-9]*\)[\.\(]\(\d*\)[\.\)\~]')
if !parts->empty()
  let name = printf('%s(%s)', parts[1], parts[2]->empty() ? '1' : parts[2])
endif
execute (bufexists(name) ? 'edit ' : '0file | file ') . name . ' | bwipeout #'
