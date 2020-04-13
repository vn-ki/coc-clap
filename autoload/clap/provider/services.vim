" description: registered services of coc.nvim
let s:services = {}

function! s:services.source() abort
  let l:serv = CocAction('services')
  if !empty(l:serv)
    return s:get_services(l:serv)
  else
    return [v:exception]
  endif
endfunction

function! s:services.sink() abort
  " TODO: Reopen after toggle
  let l:parsed = s:parse_service(a:ext[1:])
  if type(l:parsed) == v:t_dict
    silent call CocAction('toggleService', l:parsed.id)
  endif
endfunction

function! s:format_coc_service(item) abort
  " state id [state] languages
  let l:state = ' '
  if a:item.state == 'running'
    let l:state = '*'
  endif
  let l:languages = join(a:item.languageIds, ', ')
  return l:state . ' ' . a:item.id . ' [' . a:item.state . '] '. l:languages
endfunction

function! s:get_services(serv) abort
  return map(a:serv, 's:format_coc_service(v:val)')
endfunction

function! s:parse_service(ext) abort
  let l:match = matchlist(a:ext, '^\(\*\?\)\s*\(\S*\)\s\[\(\S*\)\]\s\(\S*\)')[1:4]
  if empty(l:match) || empty(l:match[1])
    return
  endif
  return ({'state' : l:match[2], 'id' : l:match[1], 'languages' : l:match[3]})
endfunction

let s:services.syntax = 'clap_services'

let g:clap#provider#services# = s:services
