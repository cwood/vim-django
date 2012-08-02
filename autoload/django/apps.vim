function! django#apps#create_app(app_name, ...)
    " Should create a app if a projects_app is specified or
    " should take a python path and create it there
    let pypath = split(a:app_name , '\.')
    let new_app = pypath[-1]

    exec 'chdir '.g:project_directory
    for app in pypath

        if app == new_app
            silent exec '! django-admin.py startapp '.new_app
            echo "Created new app at ".join(pypath, '.')
            break
        endif

        if !isdirectory(app)
            call mkdir(app)
            silent exec '!touch '.app.'/__init__.py'
        endif

        exec 'chdir '.app
    endfor
endfunction


function! django#apps#edit(file_prefix, open_as)
    " BUG: This function will have issues if the file is a model such as custom
    " models. Since this can be a __init__ file inside of the models.py.
    " Should check both for a file_prefix.py and a folder called file_prefix.
    let current_app_directory = fnamemodify(expand('%:p'), ':h')
    let python_files = split(globpath(current_app_directory, '*/'.a:file_prefix))
    if len(python_files) == 1
        let only_file = python_files[0]
        call django#utils#vim_open(only_file, a:open_as)
    endif
endfunction
