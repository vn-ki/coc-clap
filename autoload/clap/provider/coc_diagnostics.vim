" Author: vn-ki@https://github.com/vn-ki
" Description: List the diagnostics

" TODO: Icon
let s:diagnostics = {}

function! s:diagnostics.source(...) abort
  " TODO: Implement curr buffer
  let diagnostics = CocAction('diagnosticList')

  if empty(diagnostics)
    return [v:exception, 'Diagnostics empty']
  endif
  return s:get_diagnostics(diagnostics, v:false)

  return candidates
endfunction

function! s:diagnostics.on_move() abort
  let curline = g:clap.display.getcurline()
  let l:parsed = s:parse_error(curline)
  if type(l:parsed) != v:t_dict
    return
  endif

  let fpath = l:parsed['file']
  let lnum = l:parsed['linenr']
  call coc_clap#highlight_preview(fpath, lnum)
endfunction

function! s:diagnostics.sink(curline) abort
  let l:parsed = s:parse_error(a:curline)
  if type(l:parsed) == v:t_dict
    execute 'buffer' bufnr(l:parsed["file"], 1)
    call cursor(l:parsed["linenr"], l:parsed["colnr"])
    normal! zz
  endif
endfunction

function! s:format_coc_diagnostic(item) abort
  if has_key(a:item, 'file')
    let l:file = substitute(a:item.file, getcwd() . "/" , "", "")
    return l:file
          \ . ':' . a:item.lnum . ':' . a:item.col . ' '
          \ . a:item.severity . ' ' . a:item.message
  endif
  return ''
endfunction

function! s:get_diagnostics(diags, current_buffer_only) abort
  if a:current_buffer_only
    let l:diags = filter(a:diags, {key, val -> val.file ==# expand('%:p')})
  else
    let l:diags = a:diags
  endif
  return map(l:diags, 's:format_coc_diagnostic(v:val)')
endfunction

function! s:parse_error(err) abort
  let l:match = matchlist(a:err, '\v^([^:]*):(\d+):(\d+)(.*)')[1:4]
  if empty(l:match) || empty(l:match[0])
    return
  endif
  if empty(l:match[1]) && (bufnr(l:match[0]) == bufnr('%'))
    return
  endif
  let l:line_number = empty(l:match[1]) ? 1 : str2nr(l:match[1])
  let l:col_number = empty(l:match[2]) ? 1 : str2nr(l:match[2])
  let l:error_msg = l:match[3]
  return ({'file' : l:match[0],'linenr' : l:line_number, 'colnr':l:col_number, 'text': l:error_msg})
endfunction

let s:diagnostics.syntax = 'clap_diagnostics'
let g:clap#provider#coc_diagnostics# = s:diagnostics
