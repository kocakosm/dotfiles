let s:local_vimrc_path = system#user_vim_dir() . 'vimrc.local'
if filereadable(s:local_vimrc_path)
  execute 'source ' . s:local_vimrc_path
endif

let s:local_gvimrc_path = system#user_vim_dir() . 'gvimrc.local'
if has('gui_running') && filereadable(s:local_gvimrc_path)
  execute 'source ' . s:local_gvimrc_path
endif
