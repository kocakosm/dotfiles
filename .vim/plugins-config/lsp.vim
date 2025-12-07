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
\  aleSupport: v:false,
\  autoComplete: v:false,
\  autoHighlight: v:true,
\  autoHighlightDiags: v:true,
\  autoPopulateDiags: v:false,
\  bufferCompletionTimeout: 125,
\  completionKinds: {},
\  completionMatcher: 'case',
\  completionMatcherValue: 1,
\  completionTextEdit: v:true,
\  customCompletionKinds: v:false,
\  diagSignErrorText: '●',
\  diagSignHintText: '●',
\  diagSignInfoText: '●',
\  diagSignWarningText: '●',
\  diagVirtualTextAlign: 'above',
\  diagVirtualTextWrap: 'default',
\  echoSignature: v:false,
\  condensedCompletionMenu: v:false,
\  filterCompletionDuplicates: v:true,
\  hideDisabledCodeActions: v:true,
\  highlightDiagInline: v:true,
\  hoverInPreview: v:false,
\  ignoreMissingServer: v:false,
\  keepFocusInDiags: v:true,
\  keepFocusInReferences: v:true,
\  noNewlineInCompletion: v:true,
\  omniComplete: v:true,
\  omniCompleteAllowBare: v:false,
\  outlineOnRight: v:true,
\  outlineWinSize: 33,
\  popupBorder: v:false,
\  popupBorderHighlight: 'Title',
\  popupBorderHighlightPeek: 'Special',
\  popupBorderSignatureHelp: v:false,
\  popupHighlightSignatureHelp: 'Pmenu',
\  popupHighlight: 'Pmenu',
\  semanticHighlight: v:false,
\  showDiagInBalloon: v:true,
\  showDiagInPopup: v:true,
\  showDiagOnStatusLine: v:false,
\  showDiagWithSign: v:true,
\  showDiagWithVirtualText: v:false,
\  showInlayHints: v:false,
\  showSignature: v:true,
\  snippetSupport: v:false,
\  ultisnipsSupport: v:false,
\  useBufferCompletion: v:false,
\  usePopupInCodeAction: v:true,
\  useQuickfixForLocations: v:false,
\  vsnipSupport: v:false
\}

function! s:jdtls_workspace_edit(cmd)
  for e in a:cmd.arguments
    call lsp#textedit#ApplyWorkspaceEdit(e)
  endfor
endfunction

function! s:initialize() abort
  call LspOptionsSet(s:options)
  call LspAddServer(s:servers)
  call LspRegisterCmdHandler('java.apply.workspaceEdit', {cmd -> <sid>jdtls_workspace_edit(cmd)})
endfunction

augroup VimLsp
  autocmd!
  autocmd User LspSetup call <sid>initialize()
  autocmd User LspAttached let &l:complete = 'o'
augroup END
