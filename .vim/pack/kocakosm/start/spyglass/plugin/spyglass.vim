vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# spyglass.vim                                                         #
# Copyright (c) Osman Koçak <kocakosm@gmail.com>                       #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:loaded_spyglass') || &cp
  finish
endif
g:loaded_spyglass = 1

import autoload '../autoload/spyglass.vim'

command! Buffers spyglass.Buffers()
command! -nargs=? -complete=file Files spyglass.Files(<f-args>)
command! RecentlyUsed spyglass.RecentlyUsed()
