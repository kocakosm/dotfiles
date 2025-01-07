vim9script noclear
scriptencoding utf-8
#----------------------------------------------------------------------#
# spyglass/actions.vim                                                 #
# Copyright (c) Osman Koçak <kocakosm@gmail.com>                       #
# Licensed under the MIT license <https://opensource.org/licenses/MIT> #
#----------------------------------------------------------------------#

if exists('g:autoloaded_spyglass_actions') || &cp
  finish
endif
g:autoloaded_spyglass_actions = 1

export const UP = 'UP'
export const DOWN = 'DOWN'
export const HOME = 'HOME'
export const END = 'END'
export const PAGE_UP = 'PAGE_UP'
export const PAGE_DOWN = 'PAGE_DOWN'
export const FILTER_PUSH = 'FILTER_PUSH'
export const FILTER_POP = 'FILTER_POP'
export const CLEAR_FILTER = 'CLEAR_FILTER'
export const CONFIRM = 'CONFIRM'
export const CANCEL = 'CANCEL'
