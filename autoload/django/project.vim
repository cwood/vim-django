if !exists('*ActivateProject')
function! ActivateProject(project)
python << EOF
import vim
import sys
import os

os.environ['DJANGO_SETTINGS_MODULE'] = vim.eval('a:project')+'.settings'
sys.path.append(vim.eval('g:project_directory'))
EOF
endfunction
endif

function! django#project#activate(project)

    let file_regex = '**/'.a:project.'/settings.py'
    let file = split(globpath(g:django_projects, file_regex))[0]
    let g:project_directory = fnamemodify(file, ':h:h')
    let g:project_name = a:project

    if exists('g:django_activate_virtualenv')
        if exists('g:virtualenv_loaded') && g:django_activate_virtualenv == 1
            for env in virtualenv#names(a:project)
                call virtualenv#activate(env)
            endfor
        else
            echoerr 'VirtualEnv not installed. Not activating.'
        endif
    endif

    if exists('g:django_activate_nerdtree')
        if exists('g:loaded_nerd_tree') && g:django_activate_nerdtree == 1
            exec ':NERDTree '.g:project_directory
        else
            echoerr "NERDTree not installed. Can not open."
    endif

    exec 'set path+='.expand(g:project_directory)

    call ActivateProject(a:project)

endfunction
