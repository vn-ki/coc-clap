syntax case ignore
" apply syntax on everything but prompt
"exec 'syntax match CocFzf_ExtensionHeader /^\(\(\s*' . s:prompt . '\?.*\)\@!.\)*$/'
syntax match CocFzf_ExtensionRoot /\v\s*\f+$/
syntax match CocFzf_ExtensionActivited /\v^\>?\s+\*/
syntax match CocFzf_ExtensionLoaded /\v^\>?\s+\+\s/
syntax match CocFzf_ExtensionDisabled /\v^\>?\s+-\s/
syntax match CocFzf_ExtensionName /\v%3c\S+/
highlight default link CocFzf_ExtensionRoot Comment
highlight default link CocFzf_ExtensionDisabled Comment
highlight default link CocFzf_ExtensionActivited MoreMsg
highlight default link CocFzf_ExtensionLoaded Normal
highlight default link CocFzf_ExtensionName String
