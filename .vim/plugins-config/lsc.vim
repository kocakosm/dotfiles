let s:lsp_servers_dir = system#USER_DATA_DIR . 'lsp/servers/'

let g:lsc_server_commands = #{
\  java: #{
\    name: 'jdtls',
\    enabled: v:false,
\    log_level: 'Warning',
\    command: s:lsp_servers_dir . 'eclipse-jdt-ls/current/run.sh'
\  }
\}
let g:lsc_enable_autocomplete = v:false
let g:lsc_auto_map = #{defaults: v:true, Completion: 'omnifunc'}
let g:lsc_complete_timeout = 1
let g:lsc_popup_syntax = v:false

let s:code_actions = #{}

function! s:code_action(id, result)
  if a:result > 0
    let code_actions = s:code_actions->remove(a:id)
    call code_actions.callback(code_actions.actions[a:result - 1])
  endif
endfunction

function! s:code_actions_popup(actions, callback)
  let id = popup_menu(
  \  copy(a:actions)->map({_, v -> v.title}),
  \  #{
  \    callback: function('s:code_action'),
  \    borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
  \  }
  \)
  let s:code_actions[id] = #{actions: a:actions, callback: a:callback}
endfunction

let g:LSC_action_menu = function('s:code_actions_popup')

augroup LscHighlights
  autocmd!
  autocmd ColorScheme * call <sid>on_colorscheme(expand('<amatch>'))
augroup END

function! s:on_colorscheme(colorscheme) abort
  let f = expand('<SID>') . a:colorscheme
  if exists('*' . f) | execute 'call ' . f . '()' | endif
endfunction

function! s:hilal() abort
  highlight lscDiagnosticError guifg=NONE guibg=NONE gui=UNDERCURL guisp=#ea4d45
  highlight lscDiagnosticWarning guifg=NONE guibg=NONE gui=UNDERCURL guisp=#f37629
  highlight lscDiagnosticInfo guifg=NONE guibg=NONE gui=UNDERCURL guisp=#103050
  highlight lscDiagnosticHint guifg=NONE guibg=NONE gui=UNDERCURL guisp=#103050
  highlight lscReference guifg=NONE guibg=NONE gui=BOLD
  highlight lscCurrentParameter guifg=NONE guibg=NONE gui=BOLD
endfunction
