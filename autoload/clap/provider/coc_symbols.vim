" Author: vn-ki@https://github.com/vn-ki
" Description: List the workspace symbols

let s:symbols = {}

let s:kind_dict = {}
let s:kind_dict[1] = 'File'
let s:kind_dict[2] = 'Module'
let s:kind_dict[3] = 'Namespace'
let s:kind_dict[4] = 'Package'
let s:kind_dict[5] = 'Class'
let s:kind_dict[6] = 'Method'
let s:kind_dict[7] = 'Property'
let s:kind_dict[8] = 'Field'
let s:kind_dict[9] = 'Constructor'
let s:kind_dict[10] = 'Enum'
let s:kind_dict[11] = 'Interface'
let s:kind_dict[12] = 'Function'
let s:kind_dict[13] = 'Variable'
let s:kind_dict[14] = 'Constant'
let s:kind_dict[15] = 'String'
let s:kind_dict[16] = 'Number'
let s:kind_dict[17] = 'Boolean'
let s:kind_dict[18] = 'Array'
let s:kind_dict[19] = 'Object'
let s:kind_dict[20] = 'Key'
let s:kind_dict[21] = 'Null'
let s:kind_dict[22] = 'EnumMember'
let s:kind_dict[23] = 'Struct'
let s:kind_dict[24] = 'Event'
let s:kind_dict[25] = 'Operator'
let s:kind_dict[26] = 'TypeParameter'

function! s:symbols.source() abort
  let bufnr = g:clap.start.bufnr
  "if !CocHasProvider('workspaceSymbols')
  "  return [v:exception, 'Workspace symbols provider not found for current document']
  "endif
  " TODO: Impl kind
  let l:ws_symbols_opts = []
  return s:get_symbols(CocAction("getWorkspaceSymbols", '', bufnr))
endfunction

function! s:symbols.on_typed() abort
  let bufnr = g:clap.start.bufnr
  let input = g:clap.input.get()
  let syms = s:get_symbols(CocAction("getWorkspaceSymbols", input, bufnr))
  call g:clap.display.set_lines_lazy(syms)
endfunction

function! s:symbols.sink(curline) abort
  let l:parsed = s:parse_symbol(a:curline)
  if type(l:parsed) == v:t_dict
    execute 'buffer' bufnr(l:parsed["filename"], 1)
    call cursor(l:parsed["lnum"], l:parsed["col"])
    normal! zz
    call call('clap#util#blink', g:clap_provider_coc_blink)
  endif
endfunction

function! s:symbol_handler(sym) abort
  let cmd = s:action_for(a:sym[0])
  if !empty(cmd) && stridx('edit', cmd) < 0
    if stridx('edit', cmd) < 0
      execute 'silent' cmd
    endif
  endif
endfunction

function! s:format_symbols(item) abort
  "  {
  "  'kind': 23,
  "  'location':
  "     {
  "       'range':
  "         {
  "           'end': { 'character': 20, 'line': 11 },
  "           'start': {'character': 11, 'line': 11}
  "         },
  "       'uri': 'file:///home/vn-ki/git/harsark.rs/src/system/semaphore.rs'
  "     },
  "  'name': 'Semaphore', 'source': '88e58e26-70d6-4d7b-8f07-ee7a2fb74823'
  "  }

  let l:cwd = getcwd()
  let l:filename = substitute(a:item.location.uri, 'file://' . l:cwd . "/", "", "")
  let l:loc = a:item.location.range.start
  " Only use start for now
  " TODO: Highlight everything?
  return printf("%s [%s] %s %d,%d", a:item.name, s:kind_dict[a:item.kind], l:filename, l:loc.line, l:loc.character)
endfunction

function! s:get_symbols(syms) abort
  let l:syms = a:syms
  return map(l:syms, 's:format_symbols(v:val)')
endfunction

function! s:parse_symbol(sym) abort
  let l:match = matchlist(a:sym, '^\(.*\) \[\([^[]*\)\] \(.*\) \(\d\+\),\(\d\+\)')[1:5]
  if empty(l:match) || empty(l:match[0])
    return
  endif
  return ({'text': l:match[0], 'kind': l:match[1], 'filename': l:match[2], 'lnum': l:match[3], 'col': l:match[4]})
endfunction

let s:symbols.syntax = 'clap_symbols'

let g:clap#provider#coc_symbols# = s:symbols
