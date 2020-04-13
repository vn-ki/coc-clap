syntax case ignore
" apply syntax on everything but prompt
"exec 'syntax match CocFzf_OutlineHeader /^\(\(\s*' . s:prompt . '\?.*\)\@!.\)*$/'
syntax match CocFzf_OutlineSymbol /\v^>\?\s*\S\+/
syntax match CocFzf_OutlineType /\v\s\[.*\]/
syntax match CocFzf_OutlineLine /\s\d\+/
syntax match CocFzf_OutlineColumn /,\d\+$/
highlight default link CocFzf_OutlineSymbol Normal
highlight default link CocFzf_OutlineType Typedef
highlight default link CocFzf_OutlineLine Comment
highlight default link CocFzf_OutlineColumn Ignore
