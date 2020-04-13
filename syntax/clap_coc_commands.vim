syntax case ignore
" apply syntax on everything but prompt
"exec 'syntax match CocFzf_CommandHeader /^\(\(\s*' . s:prompt . '\?.*\)\@!.\)*$/'
syntax match CocFzf_CommandTitle /\s.*$/
syntax match CocFzf_CommandId /^>\?\s*\S\+/
highlight default link CocFzf_CommandTitle Comment
