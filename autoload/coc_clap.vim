function! coc_clap#highlight_preview(fpath, lnum) abort
  let [start, end, hi_lnum] = clap#preview#get_range(a:lnum)
  let lines = readfile(expand(a:fpath), '')
  let preview_lines = lines[start : end]
  call insert(preview_lines, a:fpath)
  let hi_lnum += 1
  call clap#preview#show_lines(preview_lines, clap#ext#into_filetype(a:fpath), hi_lnum)
  call clap#preview#highlight_header()
endfunction
