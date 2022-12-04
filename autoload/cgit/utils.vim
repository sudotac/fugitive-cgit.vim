if exists('g:autoloaded_fugitive_cgit_utils')
    finish
endif
let g:autoloaded_fugitive_cgit_utils = 1

function! cgit#utils#throw(string) abort
    let v:errmsg = 'cgit: '.a:string
    throw v:errmsg
endfunction

function! cgit#utils#parse_cgit_domains() abort
    let dict_or_list = get(g:, 'fugitive_cgit_domains', {})
    let domains = {} " no pre-defined domains

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
