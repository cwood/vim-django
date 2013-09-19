function! django#commands#manage(command, ...)
    let file_regex = '**/manage.py'
    let manage = split(globpath(g:django_project_directory, file_regex))[0]
    execute '!python '.manage.' '.a:command
endfunction

function! django#commands#admin(command, ...)
    execute '! django-admin.py '. a:command
endfunction
