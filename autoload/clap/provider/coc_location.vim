" Author: vn-ki@https://github.com/vn-ki
" Description: List the location items

let s:location = {}

function! s:location.source() abort
  let l:locs = deepcopy(get(g:, 'coc_jump_locations', ''))
  if !empty(l:locs)
    return s:get_location(l:locs)
  else
    " TODO: v:exception
    return []
  endif
endfunction

function! s:location.sink(curline) abort
  let l:parsed = s:parse_location(a:curline)
  if l:parsed isnot v:null
    execute 'buffer' bufnr(l:parsed["filename"], 1)
    call cursor(l:parsed["lnum"], l:parsed["col"])
    normal! zz
    call call('clap#util#blink', g:clap_provider_coc_blink)
  endif
endfunction

function! s:location_sink_star(lines) abort
  let l:items = []
  for line in a:lines
    let l:parsed = s:parse_location(line)
    if l:parsed isnot v:null
      call add(l:items, l:parsed)
    endif
  endfor
  call clap#util#open_quickfix(l:items)
endfunction

function! s:location.on_move() abort
  let curline = g:clap.display.getcurline()
  let l:parsed = s:parse_location(curline)
  if l:parsed is v:null
    return
  endif

  let fpath = l:parsed['filename']
  let lnum = l:parsed['lnum']
  call coc_clap#highlight_preview(fpath, lnum)
endfunction

function! s:format_coc_location(item) abort
  " original is: 'filename' |'lnum' col 'col'| 'text'
  " coc fzf  is: 'filename':'lnum':'col':'text'
  " reason: this format is needed for fzf preview
  let l:cwd = getcwd()
  let l:filename = substitute(a:item.filename, l:cwd . "/", "", "")
  return l:filename . ':' . a:item.lnum . ':' . a:item.col . ':' . a:item.text
endfunction

function! s:get_location(locs) abort
  let l:locs = a:locs
  return map(l:locs, 's:format_coc_location(v:val)')
endfunction

function! s:parse_location(loc) abort
  let l:match = matchlist(a:loc, '^\(\S\+\):\(\d\+\):\(\d\+\):\(.*\)')[1:4]
  if empty(l:match) || empty(l:match[0])
    return v:null
  endif
  return {'filename': l:match[0], 'lnum': l:match[1], 'col': l:match[2], 'text': l:match[3]}
endfunction

let s:location.syntax = 'clap_location'
let s:location.on_move_async = { -> clap#client#call_on_move(
      \ 'on_move',
      \ function('clap#impl#on_move#handler'),
      \ {'enable_icon': v:false, 'provider_id': 'coc_location'},
      \ )}
let s:location['sink*'] = function('s:location_sink_star')
let g:clap#provider#coc_location# = s:location
