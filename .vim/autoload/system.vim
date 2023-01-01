function! system#mkdir(path, mode = 0o700) abort
  call mkdir(expand(a:path), 'p', a:mode)
endfunction

function! system#open(location) abort
  if !executable('xdg-open')
    throw 'system#open: xdg-open not available'
  endif
  silent! let result = systemlist('xdg-open ' . a:location)
  if v:shell_error
    let msg = empty(result)
          \ ? 'Can''t open ' . a:location
          \ : trim(split(join(result, ' '), ':')[-1])
    call message#warn('system#open: ' . msg)
  endif
endfunction

function! s:expand(var, default)
  let dir = expand(exists(a:var) ? a:var : a:default)
  return strcharpart(dir, strchars(dir) - 1, 1) ==# '/' ? dir : dir . '/'
endfunction

const s:UNIX_USER_CACHE_DIR = s:expand('$XDG_CACHE_HOME', '$HOME/.cache')
const s:UNIX_USER_CONFIG_DIR = s:expand('$XDG_CONFIG_HOME', '$HOME/.config')
const s:UNIX_USER_DATA_DIR = s:expand('$XDG_DATA_HOME', '$HOME/.local/share')
const s:UNIX_USER_STATE_DIR = s:expand('$XDG_STATE_HOME', '$HOME/.local/state')
const s:UNIX_USER_BIN_DIR = expand('$HOME/.local/bin/')
const s:UNIX_USER_VIM_DIR = expand('$HOME/.vim/')

function! system#user_cache_dir() abort
  return s:UNIX_USER_CACHE_DIR
endfunction

function! system#user_config_dir() abort
  return s:UNIX_USER_CACHE_DIR
endfunction

function! system#user_data_dir() abort
  return s:UNIX_USER_DATA_DIR
endfunction

function! system#user_state_dir() abort
  return s:UNIX_USER_STATE_DIR
endfunction

function! system#user_bin_dir() abort
  return s:UNIX_USER_BIN_DIR
endfunction

function! system#user_vim_dir() abort
  return s:UNIX_USER_VIM_DIR
endfunction
