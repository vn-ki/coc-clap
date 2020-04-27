" Author: vn-ki@https://github.com/vn-ki
" Description: List/manage the coc extensions

let s:extensions = {}

let s:state_map = {'activated': '*', 'disabled': '-', 'loaded': '+'}

function! s:into_line(extension) abort
  let state = get(s:state_map, a:extension.state, '?')
  return state.' '.a:extension.id.' '.a:extension.version.' '.a:extension.root
endfunction

function! s:extensions.source() abort
  return map(CocAction('extensionStats'), 's:into_line(v:val)')
endfunction

function! s:extract_id(line) abort
  return matchstr(a:line, '. \zs\(.*\)\ze \d\+.\d\+.\d\+')
endfunction

function! s:extensions.sink(selected) abort
  call CocAction('toggleExtension', s:extract_id(a:selected))
endfunction

function! s:invoke_action(cmd, msg) abort
  let id = s:extract_id(g:clap.display.getcurline())
  call CocAction(a:cmd, id)
  " Refresh the source list to reflect the changes
  let refreshed_source = s:extensions.source()
  call g:clap.display.set_lines(refreshed_source)
  if a:cmd ==# 'uninstallExtension'
    let g:clap.display.initial_size = len(refreshed_source)
    call clap#indicator#set_matches_number(len(refreshed_source))
  endif
  call clap#helper#echo_info('extension '.id.' '.a:msg)
endfunction

let s:extensions.syntax = 'clap_coc_extensions'
let s:extensions.action = {
      \ '&Uninstall': { -> s:invoke_action('uninstallExtension', 'uninstalled') },
      \ '&Reload': { -> s:invoke_action('reloadExtension', 'reloaded') },
      \ '&Deactivate': { -> s:invoke_action('deactivateExtension', 'deactivated') },
      \ '&Toggle': { -> s:invoke_action('toggleExtension', 'toggled') },
      \ }
let g:clap#provider#coc_extensions# = s:extensions
