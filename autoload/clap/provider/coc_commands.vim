" Author: vn-ki@https://github.com/vn-ki
" Description: List the registered commands of coc.nvim

let s:commands = {}

function! s:commands.source() abort
  let l:cmds = CocAction('commands')
  if !empty(l:cmds)
    return s:get_commands(l:cmds)
  else
    return [v:exception]
  endif
endfunction

function! s:commands.sink(curline) abort
  let l:parsed = s:parse_command(a:curline)
  if type(l:parsed) == v:t_dict
    call CocActionAsync('runCommand', l:parsed.id)
  endif
endfunction

function! s:format_coc_command(item) abort
  return a:item.id . ' ' . a:item.title
endfunction

function! s:get_commands(cmds) abort
  return map(a:cmds, 's:format_coc_command(v:val)')
endfunction

function! s:parse_command(cmd) abort
  let l:match = matchlist(a:cmd, '^\(\S\+\)\s\(.*\)$')[1:2]
  if empty(l:match) || empty(l:match[1])
    return
  endif
  return ({'id' : l:match[0], 'title' : l:match[1]})
endfunction

let s:commands.syntax = 'clap_coc_commands'

let g:clap#provider#coc_commands# = s:commands
