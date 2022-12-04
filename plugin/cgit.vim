" cgit.vim - cgit support for fugitive.vim
" Maintainer:   sudotac <sudo@tofuyard.net>
" Version:      1.0.0

" Plugs in to fugitive.vim and provides a cgit hook for :GBrowse
" Relies on fugitive.vim by tpope <http://tpo.pe>
" See fugitive.vim for more details
" Requires fugitive.vim 3.0 or greater
"
" There is no pre-defined repository.
" You need to specify the cgit domains for your cgit instance.
" e.g.
"   let g:fugitive_cgit_domains = ['https://git.example.com']

if exists('g:loaded_fugitive_cgit')
    finish
endif
let g:loaded_fugitive_cgit = 1


" Fugitive {{{
if !exists('g:fugitive_browse_handlers')
    let g:fugitive_browse_handlers = []
endif

if index(g:fugitive_browse_handlers, function('cgit#fugitive#handler')) < 0
    call insert(g:fugitive_browse_handlers, function('cgit#fugitive#handler'))
endif
" }}}

" vim: set ts=4 sw=4 et foldmethod=marker foldnestmax=1 :
