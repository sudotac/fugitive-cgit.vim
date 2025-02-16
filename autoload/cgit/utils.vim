if exists('g:autoloaded_fugitive_cgit_utils')
    finish
endif
let g:autoloaded_fugitive_cgit_utils = 1
let s:default_domains = {
    \ 'android-git.linaro.org': {
    \     'root': 'https://android-git.linaro.org',
    \     'prefix': '/git',
    \ },
    \ 'anongit.mindrot.org': 'https://anongit.mindrot.org',
    \ 'cgit.adelielinux.org': {
    \     'root': 'https://cgit.adelielinux.org',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'code.qt.io': 'https://code.qt.io/cgit',
    \ 'evilpiepirate.org': 'https://evilpiepirate.org/git',
    \ 'git.automotivelinux.org': {
    \     'root': 'https://git.automotivelinux.org',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.busybox.net': {
    \     'root': 'https://git.busybox.net',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.causal.agency': {
    \     'root': 'https://git.causal.agency',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.dpkg.org': {
    \     'root': 'https://git.dpkg.org/cgit',
    \     'prefix': '/git',
    \ },
    \ 'git.etalabs.net': {
    \     'root': 'https://git.etalabs.net/cgit',
    \     'prefix': '/git',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.freebsd.org': {
    \     'root': 'https://cgit.freebsd.org',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.joeyh.name': {
    \     'root': 'https://git.joeyh.name/index.cgi',
    \     'prefix': '/git',
    \ },
    \ 'git.kernel.org': 'https://git.kernel.org',
    \ 'git.launchpad.net': {
    \     'root': 'https://git.launchpad.net',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.linaro.org': 'https://git.linaro.org',
    \ 'git.musl-libc.org': {
    \     'root': 'https://git.musl-libc.org/cgit',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.netfilter.org': {
    \     'root': 'https://git.netfilter.org',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.openembedded.org': {
    \     'root': 'https://git.openembedded.org',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.pengutronix.de': {
    \     'root': 'https://git.pengutronix.de/cgit',
    \     'prefix': '/git',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.replicant.us': {
    \     'root': 'https://git.replicant.us',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.savannah.gnu.org': {
    \     'root': 'https://git.savannah.gnu.org/cgit',
    \     'prefix': '/git'
    \ },
    \ 'git.savannah.nongnu.org': {
    \     'root': 'https://git.savannah.nongnu.org/cgit',
    \     'prefix': '/git'
    \ },
    \ 'git.skarnet.org': {
    \     'root': 'https://git.skarnet.org/cgi-bin/cgit.cgi',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.ti.com': {
    \     'root': 'https://git.ti.com/cgit',
    \     'prefix': '/git',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.tt-rss.org': 'https://git.tt-rss.org',
    \ 'git.yoctoproject.org': {
    \     'root': 'https://git.yoctoproject.org',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'git.zx2c4.com': {
    \     'root': 'https://git.zx2c4.com',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'sourceware.org': {
    \     'root': 'https://sourceware.org/cgit',
    \     'prefix': '/git',
    \     'remove-git-suffix': v:true,
    \ },
    \ 'w1.fi': {
    \     'root': 'https://w1.fi/cgit',
    \     'remove-git-suffix': v:true,
    \ },
\ }

function! cgit#utils#throw(string) abort
    let v:errmsg = 'cgit: '.a:string
    throw v:errmsg
endfunction

function! cgit#utils#parse_cgit_domains() abort
    let dict_or_list = get(g:, 'fugitive_cgit_domains', {})
    let domains = s:default_domains

    if type(dict_or_list) == type([])
        for domain in dict_or_list
            let lhs = substitute(substitute(domain, '^.\{-\}://', '', ''), '/.*', '', '')
            let domains[lhs] = {'root': domain}
        endfor
    elseif type(dict_or_list) == type({})
        for [key, val] in items(dict_or_list)
            if type(val) == type('')
                let domains[key] = {'root': val}
            elseif type(val) == type({})
                if !has_key(val, 'root')
                    call cgit#utils#throw($"g:fugitive_cgit_domains['{key}']['root'] is required")
                endif
                let domains[key] = val
            else
                call cgit#utils#throw($"g:fugitive_cgit_domains['{key}'] should be a string or a dictionary")
            endif
        endfor
    endif
    return domains
endfunction

" vim: set ts=4 sw=4 et foldmethod=indent foldnestmax=1 :
