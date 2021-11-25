scriptencoding utf-8

let g:lsp_diagnostics_enabled=1
let g:lsp_diagnostics_echo_cursor=0
let g:lsp_diagnostics_float_cursor=1
let g:lsp_diagnostics_highlights_enabled=1
let g:lsp_diagnostics_signs_enabled=1
let g:lsp_diagnostics_signs_error={'text': '✗'}
let g:lsp_diagnostics_signs_warning={'text': '⚠'}
let g:lsp_diagnostics_signs_information={'text': '🛈'}
let g:lsp_diagnostics_signs_hint={'text': '🛈'}
let g:lsp_diagnostics_signs_priority=20
let g:lsp_document_code_action_signs_enabled=1
let g:lsp_document_code_action_signs_hint={'text': '💡'}
let g:lsp_document_highlight_enabled=1
let g:lsp_fold_enabled=0

highlight lspReference gui=BOLD
highlight link LspErrorHighlight SpellBad
"highlight link LspWarningHighlight SpellBad
"highlight link LspInformationHighlight SpellBad
"highlight link LspHintHighlight SpellBad
highlight link LspErrorText ErrorMsg
highlight link LspWarningText WarningMsg
highlight link LspInformationText Todo
highlight link LspHintText Todo
"highlight link LspErrorVirtualText ErrorMsg
"highlight link LspWarningVirtualText WarningMsg
"highlight link LspInformationVirtualText Todo
"highlight link LspHintVirtualText Todo
