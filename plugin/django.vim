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

    let file_regex = '**/settings.py'
    let arg_regex = 'v:val =~ "'.a:arg_lead.'"'

    let all_settings_files = split(globpath(g:django_projects, file_regex))

    let all_projects = []

    for setting_file in all_settings_files
        let project = fnamemodify(setting_file, ':h:t')
        call add(all_projects, project)
    endfor

    if a:arg_lead == ''
        return all_projects
    endif

    return filter(copy(all_projects), arg_regex)
endfunction

function! s:Django_Workon(project)

    let file_regex = '**/'.a:project.'/settings.py'
    let file = globpath(g:django_projects, file_regex)
    let directory = fnamemodify(file, ':h')
    let env_module  = a:project.".settings"

python << EOF
import vim
import sys
import os
os.environ['DJANGO_SETTINGS_MODULE'] = vim.eval('env_module')
directory = vim.eval('directory')
sys.path.append(directory)
EOF

endfunction

function! django#Workon(project)
    return s:Django_Workon(a:project)
endfunction

function! django#ProjectsComplete(arg_lead, ...)
    " Dont really need the rest of the args since I only need
    " the lead most character
    return s:ProjectsComplete(a:arg_lead)
endfunction

command! -nargs=1 -complete=customlist,django#ProjectsComplete DjangoProjectActivate call django#Workon(<q-args>)
