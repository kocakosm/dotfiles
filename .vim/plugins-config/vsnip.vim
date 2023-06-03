" For snippets see
" https://github.com/rafamadriz/friendly-snippets
" https://github.com/Microsoft/language-server-protocol/blob/main/snippetSyntax.md

let g:vsnip_snippet_dir = system#user_vim_dir() . 'snippets'

let options = #{recursive: 1}
call keymap#conditional_map('i', 'vsnip#available(1)', '<tab>', '<plug>(vsnip-expand-or-jump)', options)
call keymap#conditional_map('s', 'vsnip#available(1)', '<tab>', '<plug>(vsnip-expand-or-jump)', options)
call keymap#conditional_map('i', 'vsnip#jumpable(-1)', '<s-tab>', '<plug>(vsnip-jump-prev)', options)
call keymap#conditional_map('s', 'vsnip#jumpable(-1)', '<s-tab>', '<plug>(vsnip-jump-prev)', options)

nmap s <plug>(vsnip-select-text)
xmap s <plug>(vsnip-select-text)
nmap S <plug>(vsnip-cut-text)
xmap S <plug>(vsnip-cut-text)
