function! s:expand(var, default)
  let dir = expand(exists(a:var) ? a:var : a:default)
  return strcharpart(dir, strchars(dir) - 1, 1) ==# '/' ? dir : dir . '/'
endfunction

const system#USER_CACHE_HOME = s:expand('$XDG_CACHE_HOME', '$HOME/.cache')
const system#USER_CONFIG_HOME = s:expand('$XDG_CONFIG_HOME', '$HOME/.config')
const system#USER_DATA_HOME = s:expand('$XDG_DATA_HOME', '$HOME/.local/share')
const system#VIM_CONFIG_HOME = expand('$HOME' . '/.vim/')

function! system#mkdir(path, ...) abort
  if a:0 > 1
    throw 'system#mkdir: too many arguments'
  endif
  let mode = a:0 ? a:1 : 0o700
  call mkdir(expand(a:path), 'p', mode)
endfunction

function! system#open(location) abort
  if !executable('xdg-open')
    throw 'system#open: xdg-open not available'
  endif
  silent! let result = systemlist('xdg-open ' . a:location)
  if v:shell_error
    let msg = trim(split(join(result, ' '), ':')[-1])
    call message#warn(msg)
  endif
endfunction
