let s:servers = [#{
\  name: 'jdtls',
\  filetype: ['java'],
\  path: system#user_data_dir('lsp', 'servers', 'eclipse-jdt-ls', 'run.sh'),
\  args: [],
\  initializationOptions: #{
\    settings: #{
\      java: #{
\        completion: #{
\          filteredTypes: ["com.sun.*", "jdk.*", "org.graalvm.*", "sun.*"],
\        },
\      },
\    },
\  }
\}]

let s:options = #{
\  autoComplete: v:false,
\  autoHighlight: v:true,
\  completionMatcher: 'case',
\  diagSignErrorText: '●',
\  diagSignHintText: '●',
\  diagSignInfoText: '●',
\  diagSignWarningText: '●',
\  filterCompletionDuplicates: v:true,
\  hideDisabledCodeActions: v:true,
\  omniComplete: v:true,
\  outlineOnRight: v:true,
\  outlineWinSize: 33,
\  popupHighlight: 'Pmenu',
\  showDiagInBalloon: v:true,
\  usePopupInCodeAction: v:true
\}

function! s:jdtls_workspace_edit(cmd) abort
  for e in a:cmd.arguments
    call lsp#textedit#ApplyWorkspaceEdit(e)
  endfor
endfunction

function! s:on_lsp_setup() abort
  call LspOptionsSet(s:options)
  call LspAddServer(s:servers)
  call LspRegisterCmdHandler('java.apply.workspaceEdit', {cmd -> <sid>jdtls_workspace_edit(cmd)})
endfunction

function! s:on_lsp_attached() abort
  let &l:complete = 'o'
  let &showbreak=''
  xnoremap <silent> <buffer> <c-e> <cmd>LspSelectionExpand<cr>
  xnoremap <silent> <buffer> <c-s> <cmd>LspSelectionShrink<cr>
  xnoremap <silent> <buffer> <leader>r <nop>
  nnoremap <silent> <buffer> <leader>r <cmd>LspRename<cr>
  nnoremap <silent> <buffer> <a-ins> <cmd>LspCodeAction<cr>
  nnoremap <silent> <buffer> <a-r> <cmd>LspShowReferences<cr>
  nnoremap <silent> <buffer> <a-h> <cmd>LspHover<cr>
  nnoremap <silent> <buffer> <a-d> <cmd>LspDiagShow<cr>
  nnoremap <silent> <buffer> <a-i> <cmd>LspGotoImpl<cr>
  nnoremap <silent> <buffer> <c-leftmouse> <cmd>LspGotoDefinition<cr>
  nnoremap <silent> <buffer> <c-cr> <cmd>LspGotoDefinition<cr>
  nnoremap <silent> <buffer> <a-f> <cmd>LspFormat<cr>
  nnoremap <silent> <buffer> <c-s-i> <cmd>LspOrganizeImports<cr>
endfunction

augroup VimLsp
  autocmd!
  autocmd User LspSetup call <sid>on_lsp_setup()
  autocmd User LspAttached call <sid>on_lsp_attached()
augroup END
