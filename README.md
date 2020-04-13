clap :heart: coc.nvim
===============

Use [clap][clap] instead of [coc.nvim][coc.nvim] built-in fuzzy finder.

![][.github/scrot.png]

Rationale
---------

Use [clap][clap] with [coc.nvim][coc.nvim]. Forked from [coc-fzf][coc-fzf].

Commands
---------

| Command                                   | List                                                                             |
| ---                                       | ---                                                                              |
| `:Clap coc_actions`                     | Equivalent to :CocList actions                                                   |
| `:Clap coc_commands`                    | Equivalent to :CocList commands                                                  |
| `:Clap coc_diagnostics`                 | Equivalent to :CocList diagnostics.                                              |
| `:Clap coc_extensions`                  | Equivalent to :CocList extensions                                                |
| `:Clap coc_location`                    | Equivalent to :CocList location.                                                 |
| `:Clap coc_outline`                     | Equivalent to :CocList outline, with colors. Requires [ctags][ctags]             |
| `:Clap coc_symbols`                     | Equivalent to :CocList symbols                                                   |
| `:Clap coc_services`                    | Equivalent to :CocList services                                                  |
<!--| `:Clap symbols --kind {kind}`       | Equivalent to :CocList symbols -kind {kind}                                      |-->
<!--| `:Clap        `                     | Equivalent to :CocList                                                           |-->
<!--| `:Clap diagnostics --current-buf`   | Equivalent to :CocList diagnostics in the current buffer only                    |-->
<!--| `:ClapResume`                       | Equivalent to :CocListResume                                                     |-->

Options
---------

| Option                         | Type   | Description                                                    | Default value               |
| ---                            | ---    | ---                                                            | ---                         |
| `g:clap_provider_coc_blink` | List | Change blink style. [0, 0] disables blink.  | `[2, 100]`                       |

License
-------

MIT

[clap]:                https://github.com/liuchengxu/vim-clap
[coc.nvim]:            https://github.com/neoclide/coc.nvim
[coc-fzf]:             https://github.com/antoinemadec/coc-fzf
[ctags]:               https://github.com/universal-ctags/ctags
