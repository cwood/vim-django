function! django#is_active(...) abort
    return exists('g:project_name') && exists('g:project_directory')
endfunction
