" Use rg or ag if available, otherwise use recursive grep
if executable('rg')
  let &grepprg = 'rg -S --hidden --vimgrep'
  let &grepformat = '%f:%l:%c:%m'
elseif executable('ag')
  let &grepprg = 'ag -S --hidden --vimgrep'
  let &grepformat = '%f:%l:%c:%m'
else
  let &grepprg = 'grep -rn $* /dev/null'
endif
