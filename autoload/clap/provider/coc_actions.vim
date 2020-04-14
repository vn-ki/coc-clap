" Author: vn-ki@https://github.com/vn-ki
" Description: List the code actions of selected range

let s:actions = {}

function! s:actions.source() abort
  let l:bufnr = bufnr('')

  execute 'keepalt buffer' g:clap.start.bufnr
  let l:actions = CocAction('codeActions')
  execute 'keepalt buffer' l:bufnr

  if !empty(l:actions)
    return s:get_actions(l:actions)
  else
    return [v:exception]
  endif
endfunction

function! s:actions.sink(curline) abort
  let l:index = s:parse_action(a:curline)
  if type(l:index) == v:t_number
    call CocAction('doCodeAction', g:coc_fzf_actions[l:index])
  endif
endfunction

function! s:format_coc_action(item) abort
  " title [clientId] (kind)
  let l:str = a:item.title . ' [' . a:item.clientId . ']'
  if exists('a:item.kind')
    let l:str .=  ' (' . a:item.kind . ')'
  endif
  return l:str
endfunction

function! s:get_actions(act) abort
  let l:entries = map(copy(a:act), 's:format_coc_action(v:val)')
  let index = 0
  while index < len(l:entries)
     let l:entries[index] .= ' ' . index
     let index = index + 1
  endwhile
  return l:entries
endfunction

function! s:parse_action(act) abort
  let l:match = matchlist(a:act, '^.* \(\d\+\)$')[1]
  if empty(l:match)
    return
  endif
  return str2nr(l:match)
endfunction

let s:actions.syntax = 'clap_actions'

let g:clap#provider#coc_actions# = s:actions
