scriptencoding utf-8

function! s:hi() abort
  syntax case ignore
  syntax match ClapCoc_DiagnosticFile /^>\?\s*\S\+/
  syntax match ClapCoc_DiagnosticError /\sError\s/
  syntax match ClapCoc_DiagnosticWarning /\sWarning\s/
  syntax match ClapCoc_DiagnosticInfo /\sInformation\s/
  syntax match ClapCoc_DiagnosticHint /\sHint\s/
  highlight default link ClapCoc_DiagnosticFile Comment
  highlight default link ClapCoc_DiagnosticError CocErrorSign
  highlight default link ClapCoc_DiagnosticWarning CocWarningSign
  highlight default link ClapCoc_DiagnosticInfo CocInfoSign
  highlight default link ClapCoc_DiagnosticHint CocHintSign
endfunction

call s:hi()
