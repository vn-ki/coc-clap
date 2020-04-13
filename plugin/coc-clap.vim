if !exists('g:clap_provider_coc_blink')
  let g:clap_provider_coc_blink = [2, 100]
endif

augroup CocFzfLocation
  autocmd!
  let g:coc_enable_locationlist = 0
  autocmd User CocLocationsChange Clap coc_location
augroup END

