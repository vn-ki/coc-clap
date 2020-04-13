syntax case ignore
" apply syntax on everything but prompt
"exec 'syntax match CocFzf_ActionHeader /^\(\(\s*' . s:prompt . '\?.*\)\@!.\)*$/'
syntax match CocFzf_ActionKind /([^)]\+)/
syntax match CocFzf_ActionId /\[[^\]]\+\]/
syntax match CocFzf_ActionTitle /^>\?\s*[^\[]\+/
syntax match CocFzf_ActionIndex /\d\+$/
highlight default link CocFzf_ActionIndex Ignore
highlight default link CocFzf_ActionTitle Normal
highlight default link CocFzf_ActionId Type
highlight default link CocFzf_ActionKind Comment
