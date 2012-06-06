" django.vim
" Maintainer: Colin Wood <cwood06@gmail.com>
" Version: 0.0.1a

if !has('python')
    echoerr "This script wont work without Python. Please compile with it."
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
else
    let g:project_apps = expand(g:project_apps) " Should expand out incase of home dir
endif

if !isdirectory(g:django_projects)
    echoerr "Could not access ".g:django_projects
    finish
endif

function! s:ProjectsComplete(arg_lead, ...)
    " TODO: Should be able to detech wich project is a django project
    " Currently this search through all the projects. Since I use
    " a project as a whole this becomes an issue of searching through
    " the virutalenv too.

    let file_regex = '**/settings.py'
    if !exists('l:all_projects')
        let all_projects = split(fnamemodify(globpath(g:django_projects, file_regex), ':h:t'))

    return filter(all_projects, 'v:val =~ ^'.a:arg_lead)
endfunction

function! s:Django_Workon(project)
    echom a:project
endfunction

function! django#Workon(project)
    return s:Django_Workon(a:project)
endfunction

function! django#ProjectsComplete(arg_lead, ...)
    " Dont really need the rest of the args since I only need
    " the lead most character
    return s:ProjectsComplete(a:*)
endfunction

command! -nargs=1 -complete=customlist,django#ProjectsComplete DjangoProjectActivate call django#Workon(<q-args>)
command! -nargs=0 -bang DjangoProjectsUpdate call django#ProjectsComplete(<q-args> <bang>)
