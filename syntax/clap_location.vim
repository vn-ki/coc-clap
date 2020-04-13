syntax case ignore
" apply syntax on everything but prompt
"syntax region CocFzf_JumplocationRegion start="^" end="[│╭╰]" keepend contains=CocFzf_JumplocationHeader
syntax match CocFzf_JumplocationFile /^>\?\s*[^:││╭╰]\+/
syntax match CocFzf_JumplocationLineNumber /:\d\+:\d\+:/
highlight default link CocFzf_JumplocationFile Directory
highlight default link CocFzf_JumplocationLineNumber LineNr
