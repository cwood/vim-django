function! django#apps#create_app(app_name)
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
