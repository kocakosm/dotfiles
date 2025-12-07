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

function! s:expand(var, default) abort
  let dir = expand(exists(a:var) ? a:var : a:default)
  return s:append_path_separator(dir)
endfunction

function! s:append_path_separator(dir) abort
  return strcharpart(a:dir, strchars(a:dir) - 1, 1) ==# '/' ? a:dir : a:dir . '/'
endfunction

function! system#path(...) abort
  let path = ''
  if a:0 > 0
    let path = a:1
    for p in a:000[1:]
      let path = s:append_path_separator(path) . p
    endfor
  endif
  return path
endfunction

const s:UNIX_USER_CACHE_DIR = s:expand('$XDG_CACHE_HOME', '$HOME/.cache')
const s:UNIX_USER_CONFIG_DIR = s:expand('$XDG_CONFIG_HOME', '$HOME/.config')
const s:UNIX_USER_DATA_DIR = s:expand('$XDG_DATA_HOME', '$HOME/.local/share')
const s:UNIX_USER_STATE_DIR = s:expand('$XDG_STATE_HOME', '$HOME/.local/state')
const s:UNIX_USER_BIN_DIR = expand('$HOME/.local/bin/')
const s:UNIX_USER_VIM_DIR = expand('$HOME/.vim/')

function! system#user_cache_dir(...) abort
  return call('system#path', [s:UNIX_USER_CACHE_DIR] + a:000)
endfunction

function! system#user_config_dir(...) abort
  return call('system#path', [s:UNIX_USER_CONFIG_DIR] + a:000)
endfunction

function! system#user_data_dir(...) abort
  return call('system#path', [s:UNIX_USER_DATA_DIR] + a:000)
endfunction

function! system#user_state_dir(...) abort
  return call('system#path', [s:UNIX_USER_STATE_DIR] + a:000)
endfunction

function! system#user_bin_dir(...) abort
  return call('system#path', [s:UNIX_USER_BIN_DIR] + a:000)
endfunction

function! system#user_vim_dir(...) abort
  return call('system#path', [s:UNIX_USER_VIM_DIR] + a:000)
endfunction
