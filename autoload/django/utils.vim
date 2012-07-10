function! django#utils#vim_open(file, open_as)
    if a:open_as is 'tab'
        exec 'tabnew '.a:file
    elseif a:open_as is 'vsplit'
        exec 'vsplit '.a:file
    elseif a:open_as is 'split'
        exec 'split'.a:file
    endif
endfunction
