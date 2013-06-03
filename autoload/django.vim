function! django#is_active(...) abort
    return exists('g:django_project_name') && exists('g:django_project_directory')
endfunction
