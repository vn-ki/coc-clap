clap :heart: coc.nvim
===============

Use [clap][clap] instead of [coc.nvim][coc.nvim] built-in fuzzy finder.

Rationale
---------

Use [clap][clap] with [coc.nvim][coc.nvim]. Forked from [coc-fzf][coc-fzf].

Commands
---------

| Command                                   | List                                                                             |
| ---                                       | ---                                                                              |
<!--| `:Clap        `                     | Equivalent to :CocList                                                           |-->
| `:Clap coc_actions`                     | Equivalent to :CocList actions                                                   |
| `:Clap coc_commands`                    | Equivalent to :CocList commands                                                  |
| `:Clap coc_diagnostics`                 | Equivalent to :CocList diagnostics.                                              |
<!--| `:Clap diagnostics --current-buf`   | Equivalent to :CocList diagnostics in the current buffer only                    |-->
| `:Clap coc_extensions`                  | Equivalent to :CocList extensions                                                |
| `:Clap coc_location`                    | Equivalent to :CocList location.                                                 |
| `:Clap coc_outline`                     | Equivalent to :CocList outline, with colors. Requires [ctags][ctags]             |
| `:Clap coc_symbols`                     | Equivalent to :CocList symbols                                                   |
<!--| `:Clap symbols --kind {kind}`       | Equivalent to :CocList symbols -kind {kind}                                      |-->
| `:Clap coc_services`                    | Equivalent to :CocList services                                                  |
<!--| `:ClapResume`                       | Equivalent to :CocListResume                                                     |-->

Options
---------

| Option                         | Type   | Description                                                    | Default value               |
| ---                            | ---    | ---                                                            | ---                         |
| `g:coc_fzf_preview_toggle_key` | string | Change the key to toggle the preview window                    | `'?'`                       |
| `g:coc_fzf_preview`            | string | Change the preview window position                             | `'up:50%'`                  |
| `g:coc_fzf_opts`               | array  | Pass additional parameters to fzf, e.g. `['--layout=reverse']` | `['--layout=reverse-list']` |

Vimrc Example
---------
```vim
nnoremap <silent> <space>a  :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <space>b  :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <space>c  :<C-u>CocFzfList commands<CR>
nnoremap <silent> <space>e  :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <space>l  :<C-u>CocFzfList location<CR>
nnoremap <silent> <space>o  :<C-u>CocFzfList outline<CR>
nnoremap <silent> <space>s  :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <space>S  :<C-u>CocFzfList services<CR>
nnoremap <silent> <space>p  :<C-u>CocFzfListResume<CR>
```

License
-------

MIT

[clap]:                https://github.com/liuchengxu/vim-clap
[coc.nvim]:            https://github.com/neoclide/coc.nvim
[coc-fzf]:             https://github.com/antoinemadec/coc-fzf
[ctags]:               https://github.com/universal-ctags/ctags
