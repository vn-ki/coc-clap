syntax case ignore
" apply syntax on everything but prompt
"exec 'syntax match CocFzf_ExtensionHeader /^\(\(\s*' . s:prompt . '\?.*\)\@!.\)*$/'
syntax match CocFzf_ServiceStar /\*/
syntax match CocFzf_ServiceName /\v%2c[^[]*(\[)@=/
syntax match CocFzf_ServiceState /\v\[[^[\]]*\]/
syntax match CocFzf_ServiceLanguages /\v(\])@<=.*$/
highlight default link CocFzf_ServiceStar Special
highlight default link CocFzf_ServiceName Type
highlight default link CocFzf_ServiceState Statement
highlight default link CocFzf_ServiceLanguages Comment
