nnoremap <silent> zG 2zg
nnoremap <silent> zW 2zw

function! s:update_spell_file() abort
  if &spell
    call system#mkdir(system#user_data_dir('vim', 'spell'))
    silent let &spellfile=system#user_data_dir('vim', 'spell', &spelllang) . '.utf-8.add,'
    silent let &spellfile.=system#user_data_dir('vim', 'spell', 'global') . '.utf-8.add'
  endif
endfunction

augroup SpellFile
  autocmd!
  autocmd OptionSet spell,spelllang call <sid>update_spell_file()
augroup END
