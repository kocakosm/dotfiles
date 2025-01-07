vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# popterm.vim                                                          #
# Copyright (c) Osman Koçak <kocakosm@gmail.com>                       #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:loaded_popterm') || v:version < 900 || &cp
  finish
endif
g:loaded_popterm = 1

import autoload '../autoload/popterm.vim'

command! -bar PopTermToggle popterm.Toggle()
