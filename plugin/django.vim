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

function! s:Find_all_settings()
endfunction

function! s:ProjectsComplete(A,L,P)
    let file_regex = a:A.'**/settings.py'
    return split(fnamemodify(globpath(g:django_projects, file_regex), ':h:t'))
endfunction

function! s:Django_Workon(project)
    echom a:project
endfunction

function! django#Workon(project)
    return s:Django_Workon(a:project)
endfunction

function! django#ProjectsComplete(A,L,P)
    return s:ProjectsComplete(a:A, a:L, a:P)
endfunction

command! -nargs=1 -complete=customlist,django#ProjectsComplete DjangoProjectActivate call django#Workon(<q-args>)
