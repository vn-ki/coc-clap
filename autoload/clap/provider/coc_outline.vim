" Author: vn-ki@https://github.com/vn-ki
" Description: List the symbols of current document

let s:outline = {}

function! s:outline.source() abort
  let l:bufnr = bufnr('')

  execute 'keepalt buffer' g:clap.start.bufnr
  let l:outline = s:get_outline()
  execute 'keepalt buffer' l:bufnr

  return l:outline
endfunction

function! s:outline.sink(curline) abort
  let l:parsed = s:parse_symbol(a:curline)
  if type(l:parsed) == v:t_dict
    call cursor(l:parsed["lnum"], l:parsed["col"])
    normal! zz
    call call('clap#util#blink', g:clap_provider_coc_blink)
  endif
endfunction

function! s:format_coc_outline_ctags(item) abort
  if len(a:item) >= 4
    let l:parts = split(a:item, "\t")
    let l:sym = parts[0]
    let l:line = substitute(parts[2], ';".*$', '', '')
    let l:type = '[' . parts[3] . ']'
    call cursor(l:line, 0)
    let [l:l, l:col] = searchpos('\V'.l:sym, 'nc', l:line)
    return l:sym . " " . l:type . " " . l:line . ',' . l:col
  else
    return ''
  endif
endfunction

function! s:format_coc_outline_docsym(item) abort
  let l:msg = a:item.text . ' [' . a:item.kind . '] ' . a:item.lnum . ',' . a:item.col
  let l:indent = ''
  let l:c = 0
  while l:c < a:item.level
    let l:indent .= '  '
    let l:c += 1
  endwhile
  return l:indent . l:msg
endfunction

function! s:get_outline() abort
  let l:symbols = CocAction('documentSymbols')
  if type(l:symbols) != v:t_list
    " ctags: try force language to filtetype
    let l:ctags_base_cmd = 'set -o pipefail && ctags -f - --excmd=number'
    let l:shell_cmd = l:ctags_base_cmd . " --language-force=" . &ft . ' '  . expand("%")
          \ . ' | sort -n --key=3'
    let l:symbols = systemlist(shell_cmd)
    if (!(len(l:symbols) && v:shell_error == 0))
      " ctags: try without forcing language
      let l:shell_cmd = l:ctags_base_cmd . ' '  . expand("%") . ' | sort -n --key=3'
      let l:symbols = systemlist(shell_cmd)
    endif
    let l:cur_pos = getpos('.')
    let l:return_list = v:shell_error == 0 ? map(l:symbols, 's:format_coc_outline_ctags(v:val)'):[]
    call cursor(l:cur_pos[1:2])
    return l:return_list
  else
    return map(l:symbols, 's:format_coc_outline_docsym(v:val)')
  endif
endfunction

function! s:parse_symbol(sym) abort
  let l:match = matchlist(a:sym, '^\s*\(.*\) \[\([^[]*\)\] \(\d\+\),\(\d\+\)')[1:4]
  if empty(l:match) || empty(l:match[0])
    return
  endif
  return ({'text': l:match[0], 'kind': l:match[1], 'lnum': l:match[2], 'col': l:match[3]})
endfunction

let s:outline.syntax = 'clap_outline'

let g:clap#provider#coc_outline# = s:outline
