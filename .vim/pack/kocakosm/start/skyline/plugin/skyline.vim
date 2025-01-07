vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# skyline.vim                                                          #
# Copyright (c) Osman Koçak <kocakosm@gmail.com>                       #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:loaded_skyline') || v:version < 900 || &cp
  finish
endif
g:loaded_skyline = 1

g:qf_disable_statusline = 1

&statusline = '%!skyline#StatusLine()'
