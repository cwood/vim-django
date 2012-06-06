" django.vim
" Maintainer: Colin Wood <cwood06@gmail.com>
" Version: 0.0.1a

if !has('python')
    echoerr "No Python found."
endif

if !exists('g:django_projects')
    " Where the projects are stored at. Will start from this
    " root and search down for all someapp.settings files
    let g:django_projects = expand('~/Projects')
endif


if !exists('g:project_apps')
    " Sets where to put new apps. If nothing is selected it will
    " just add it to the root of the django project.
    let g:project_apps = 0
endif

if !isdirectory(g:django_projects)
    echoerr "Could not access ".g:django_projects
    finish
endif

function! s:find_all_settings()
    return split(globpath(g:django_projects, '**/settings.py'))
endfunction

function! s:Projects()
    let all_settings = s:find_all_settings()
    let projects = []

    for setting in all_settings
        let name = fnamemodify(fnamemodify(setting, ':h'), ':t')
        call add(projects, name)
    endfor
endfunction

call s:Projects()
