" Various improvements to the built-in grep command

function! s:set_grepprg() abort
  const rg_ag_case_option = &ignorecase ? (&smartcase ? '-S' : '-i') : '-s'
  if executable('rg')
    let &grepprg = 'rg ' . rg_ag_case_option . ' --hidden --vimgrep'
    let &grepformat = '%f:%l:%c:%m'
  elseif executable('ag')
    let &grepprg = 'ag ' . rg_ag_case_option . ' --hidden --vimgrep'
    let &grepformat = '%f:%l:%c:%m'
  else
    let &grepprg = 'grep -rn'
  endif
endfunction

call s:set_grepprg()

let s:has_result = 0

function! s:grep(...) abort
  try
    let in = expand(a:000[-1])
  catch
    let in = ''
  endtry
  if isdirectory(in) || filereadable(glob(in))
    const query = shellescape(join(a:000[0:-2], ' '))
  else
    let in = getcwd()
    const query = shellescape(join(a:000, ' '))
  endif
  let result = system(&grepprg . ' ' . query . ' ' . in)
  let s:has_result = !empty(result)
  if !s:has_result
    call message#warn('[grep] No result for ' . query . ' in ' . fnamemodify(in, ':~:.'))
  elseif v:shell_error
    call message#warn('[grep] ' . result)
    let result = ''
    let s:has_result = 0
  endif
  return result
endfunction

function! s:on_grep() abort
  call setqflist([], 'a', {'title': ''})
  cwindow
endfunction

function! s:on_lgrep() abort
  call setloclist(0, [], 'a', {'title': ''})
  lwindow
endfunction

function! s:on_grepadd() abort
  if s:has_result | call s:on_grep() | endif
endfunction

function! s:on_lgrepadd() abort
  if s:has_result | call s:on_lgrep() | endif
endfunction

command! -nargs=+ -complete=file -bar Grep cgetexpr <sid>grep(<f-args>)
command! -nargs=+ -complete=file -bar Grepadd caddexpr <sid>grep(<f-args>)
command! -nargs=+ -complete=file -bar LGrep lgetexpr <sid>grep(<f-args>)
command! -nargs=+ -complete=file -bar LGrepadd laddexpr <sid>grep(<f-args>)

cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep'
cnoreabbrev <expr> grepa (getcmdtype() ==# ':' && getcmdline() ==# 'grepa') ? 'Grepa' : 'grepa'
cnoreabbrev <expr> grepad (getcmdtype() ==# ':' && getcmdline() ==# 'grepad') ? 'Grepad' : 'grepad'
cnoreabbrev <expr> grepadd (getcmdtype() ==# ':' && getcmdline() ==# 'grepadd') ? 'Grepadd' : 'grepadd'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'
cnoreabbrev <expr> lgrepa (getcmdtype() ==# ':' && getcmdline() ==# 'lgrepa') ? 'LGrepa' : 'lgrepa'
cnoreabbrev <expr> lgrepad (getcmdtype() ==# ':' && getcmdline() ==# 'lgrepad') ? 'LGrepad' : 'lgrepad'
cnoreabbrev <expr> lgrepadd (getcmdtype() ==# ':' && getcmdline() ==# 'lgrepadd') ? 'LGrepadd' : 'lgrepadd'

augroup Grep
  autocmd!
  autocmd QuickFixCmdPost cgetexpr call <sid>on_grep()
  autocmd QuickFixCmdPost caddexpr call <sid>on_grepadd()
  autocmd QuickFixCmdPost lgetexpr call <sid>on_lgrep()
  autocmd QuickFixCmdPost laddexpr call <sid>on_lgrepadd()
  autocmd OptionSet ignorecase,smartcase call <sid>set_grepprg()
augroup END
