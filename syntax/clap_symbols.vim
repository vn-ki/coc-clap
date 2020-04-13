syntax case ignore
syntax match CocFzf_SymbolsSymbol /\v^>\?\s*\S\+/
syntax match CocFzf_SymbolsType /\v\s\[.*\]/
syntax match CocFzf_SymbolsFile /\s\S*\s\d\+,\d\+$/
syntax match CocFzf_SymbolsLine /\s\d\+/
syntax match CocFzf_SymbolsColumn /,\d\+$/
highlight default link CocFzf_SymbolsSymbol Normal
highlight default link CocFzf_SymbolsType Typedef
highlight default link CocFzf_SymbolsFile Comment
highlight default link CocFzf_SymbolsLine Ignore
highlight default link CocFzf_SymbolsColumn Ignore
