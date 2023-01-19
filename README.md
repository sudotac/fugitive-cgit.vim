# fugitive-cgit.vim

[![Fugitive cgit](https://github.com/sudotac/fugitive-cgit.vim/actions/workflows/vader.yml/badge.svg?branch=master)](https://github.com/sudotac/fugitive-cgit.vim/actions/workflows/vader.yml)

[fugitive.vim][] is undoubtedly the best Git wrapper of all time.

This plugin allows you to use it with a cgit instance.

* Enables `:GBrowse` from fugitive.vim to open cgit URLs

## Installation

Install it as you would install [fugitive.vim][]
(you will also need [fugitive.vim][] installed)

To use cgit instances, add the following to your .vimrc

    let g:fugitive_cgit_domains = ['https://git.example.com']

If the cgit instance uses different URLs, for example, one for SSH and another
for HTTPS, instead add the following to your .vimrc

    let g:fugitive_cgit_domains = {'ssh://git.example.com': 'https://git.example.com'}

Fugitive command `:GBrowse` will now work with cgit URLs.

If you need more complicated configuration, please refer to
`:help fugitive-cgit-config` for more details.

## Requirements

fugitive-cgit.vim requires a modern [fugitive.vim][].

[fugitive.vim]: https://github.com/tpope/vim-fugitive

## Examples

### Linux kernel git repository

```vim
let g:fugitive_cgit_domains = ['https://git.kernel.org']
```

### ZX2C4 Git Repository

```vim
let g:fugitive_cgit_domains = {
    \     'https://git.zx2c4.com': {
    \         'root': 'https://git.zx2c4.com',
    \         'remove-git-suffix': v:true
    \     }
    \ }
```

### GNU's Savannah

```vim
let g:fugitive_cgit_domains = {
    \     'https://git.savannah.gnu.org': {
    \         'root': 'https://git.savannah.gnu.org/cgit',
    \         'prefix': 'git'
    \     }
    \ }
```

## License

This plugin is distributed under the term of CC0.
See COPYING.txt for more details.

This plugin is based on [fugitive-gitlab.vim](https://github.com/shumphrey/fugitive-gitlab.vim),
which is distributed under the term of the MIT License.
You also have to follow LICENSE.fugitive-gitlab if you want to use this plugin.

## FAQ

> Why doesn't this plugin have a pun name?

I couldn't think of one, either.
