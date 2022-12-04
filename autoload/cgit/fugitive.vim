if exists('g:autoloaded_fugitive_cgit_fugitive')
    finish
endif
let g:autoloaded_fugitive_cgit_fugitive = 1

function! cgit#fugitive#handler(opts, ...)
    let path   = substitute(get(a:opts, 'path', ''), '^/', '', '')
    let commit = get(a:opts, 'commit')
    let type   = get(a:opts, 'type')
    let line1  = get(a:opts, 'line1')
    let line2  = get(a:opts, 'line2')
    let remote = get(a:opts, 'remote')

    let root = cgit#fugitive#homepage_for_remote(remote)
    if empty(root)
        return ''
    endif

    " work out what branch/commit/tag/etc we're on
    " if file is a git/ref, we can go to a /commit cgit url
    " If the branch/tag doesn't exist upstream, the URL won't be valid
    " Could check upstream refs?
    if path =~# '^\.git/refs/heads/'
        return root . '/log/' . path[16:-1]
    elseif path =~# '^\.git/refs/tags/'
        return root . '/tag/?h=' . path[15:-1]
    elseif path =~# '^\.git/refs/.'
        return root . '/commit/' . path[10:-1]
    elseif path =~# '^\.git\>'
        return root
    endif

    " check if 'commit' is actually commit-id or not.
    " FIXME: cannot handle the branch name which consists of 40 character hex string.
    " It's technically possible, though I haven't seen such a branch name...
    if commit =~# '^\x\{40\}'
        let key = 'id'
    else
        let key = 'h'
    endif

    if type ==# 'tree' || path =~# '/$'
        let path = substitute(path, '/$', '', '')
        let dir = 'tree'
    elseif type ==# 'blob' || path =~# '[^/]$'
        let dir = 'tree'
    else
        let dir = 'commit'
    endif

    " NOTE: Range selection is not supported in cgit
    return root.'/'.dir.'/'.path.'?'.key.'='.commit.(line2 ? '#n'.line1 : '')
endfunction

function! cgit#fugitive#homepage_for_remote(url) abort
    let domains = cgit#utils#parse_cgit_domains()

    " https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols
    " [full_url, scheme, host_with_port, host, path]
    " NOTE: In cgit, '.git' suffix should be preserved as-is.
    if a:url =~# '://'
        let match = matchlist(a:url, '^\(https\=://\|git://\|ssh://\)\%([^@/]\+@\)\=\(\([^/:]\+\)\%(:\d\+\)\=\)\(.\{-\}\%(\.git\)\=\)/\=$')
    else
        let match = matchlist(a:url, '^\([^@/]\+@\)\=\(\([^:/]\+\)\):\(.\{-\}\%(\.git\)\=\)/\=$')
        if empty(match)
            return ''
        endif
        let match[1] = 'ssh://'
    endif

    if empty(match)
        return ''
    elseif has_key(domains, match[1] . match[2])
        let key = match[1] . match[2]
    elseif has_key(domains, match[1] . match[3])
        let key = match[1] . match[3]
    elseif has_key(domains, match[2])
        let key = match[2]
    elseif has_key(domains, match[3])
        let key = match[3]
    else
        return ''
    endif

    let root = get(domains[key], 'root')
    if empty(root)
        return ''
    elseif root !~# '://'
        let root = (match[1] =~# '^http://' ? 'http://' : 'https://') . root
    endif

    let path = match[4]
    if get(domains[key], 'remove-git-suffix')
        let path = substitute(path, '\.git$', '', '')
    endif

    let prefix = get(domains[key], 'prefix')
    if type(prefix) == type('') && !empty(prefix) && strpart(path, 0, strlen(prefix)) == prefix
        let path = strpart(path, strlen(prefix))
    endif
    return substitute(root, '/\+$', '', '') . '/' . substitute(path, '^/\+', '', '')
endfunction

" vim: set ts=4 sw=4 et foldmethod=indent foldnestmax=1 :
