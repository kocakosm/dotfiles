set shortmess+=c

let g:asyncomplete_auto_popup=0
let g:asyncomplete_popup_delay=0
let g:asyncomplete_auto_completeopt=0

inoremap <silent><expr> <c-space> pumvisible() ? "\<C-n>" : asyncomplete#force_refresh()
inoremap <silent><expr> <c-s-space> pumvisible() ? "\<C-p>" : asyncomplete#force_refresh()
