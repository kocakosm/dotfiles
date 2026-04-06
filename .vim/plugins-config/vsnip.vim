" For snippets see
" https://github.com/rafamadriz/friendly-snippets
" https://github.com/Microsoft/language-server-protocol/blob/main/snippetSyntax.md

let g:vsnip_snippet_dir = system#user_vim_dir('snippets')

imap <expr> <tab> vsnip#jumpable(1) ? '<plug>(vsnip-jump-next)' : (vsnip#expandable() ? '<plug>(vsnip-expand)' : '<tab>')
smap <expr> <tab> vsnip#jumpable(1) ? '<plug>(vsnip-jump-next)' : (vsnip#expandable() ? '<plug>(vsnip-expand)' : '<tab>')
smap <expr> <cr> vsnip#jumpable(1) ? '<plug>(vsnip-jump-next)' : '<cr>'
imap <expr> <s-tab> vsnip#jumpable(-1) ? '<plug>(vsnip-jump-prev)' : '<s-tab>'
smap <expr> <s-tab> vsnip#jumpable(-1) ? '<plug>(vsnip-jump-prev)' : '<s-tab>'

nmap s <plug>(vsnip-select-text)
xmap s <plug>(vsnip-select-text)
nmap S <plug>(vsnip-cut-text)
xmap S <plug>(vsnip-cut-text)
