" Use rg or ag if available, fallback to recursive grep otherwise
function! s:set_grepprg() abort
  let rg_ag_case_option = &ignorecase ? (&smartcase ? '-S' : '-i') : '-s'
  if executable('rg')
    let &grepprg = 'rg ' . rg_ag_case_option . ' --hidden --vimgrep'
    let &grepformat = '%f:%l:%c:%m'
  elseif executable('ag')
    let &grepprg = 'ag ' . rg_ag_case_option . ' --hidden --vimgrep'
    let &grepformat = '%f:%l:%c:%m'
  else
    let &grepprg = 'grep -rn $* /dev/null'
  endif
endfunction

augroup UpdateGrepprg
  autocmd!
  autocmd OptionSet ignorecase,smartcase call <sid>set_grepprg()
augroup END

call s:set_grepprg()
