" Author: vn-ki@https://github.com/vn-ki
" Description: List/manage the coc extensions

let s:extensions = {}

function! s:extensions.source() abort
  " TODO: Wait for custom actions
  let l:exts = CocAction('extensionStats')
  if !empty(l:exts)
    return s:get_extensions(l:exts)
  else
    return [v:exception]
  endif
endfunction

function! s:extensions.sink() abort

endfunction

function! s:format_coc_extension(item) abort
  " state id version root
  let l:state = '+'
  if a:item.state == 'activated'
    let l:state = '*'
  elseif a:item.state == 'disabled'
    let l:state = '-'
  endif
  return l:state . ' ' . a:item.id . ' ' . a:item.root
endfunction

function! s:get_extensions(exts) abort
  let l:exts_activated = filter(copy(a:exts), {key, val -> val.state == 'activated'})
  let l:exts_loaded = filter(copy(a:exts), {key, val -> val.state == 'loaded'})
  let l:exts_disabled = filter(copy(a:exts), {key, val -> val.state == 'disabled'})
  let l:exts = extend(l:exts_activated, l:exts_loaded)
  let l:exts = extend(l:exts, l:exts_disabled)
  return map(l:exts, 's:format_coc_extension(v:val)')
endfunction

function! s:syntax() abort
  if has('syntax') && exists('g:syntax_on')
  endif
endfunction

function! s:extension_handler(ext) abort
  let l:parsed = s:parse_extension(a:ext[1:])
  if type(l:parsed) == v:t_dict
    if l:parsed.state == '*'
      silent call CocAction('deactivateExtension', l:parsed.id)
    elseif l:parsed.state == '+'
      silent call CocAction('activeExtension', l:parsed.id)
    endif
    call coc_fzf#extensions#fzf_run(0)
  endif
endfunction

function! s:parse_extension(ext) abort
  let l:match = matchlist(a:ext, '\v^(.)\s(\S*)\s(.*)')[1:4]
  if empty(l:match) || empty(l:match[0])
    return
  endif
  return ({'state' : l:match[0], 'id' : l:match[1], 'root' : l:match[2]})
endfunction

let s:extensions.syntax = 'clap_coc_extensions'

let g:clap#provider#coc_extensions# = s:extensions
