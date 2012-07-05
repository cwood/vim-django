function! django#project#activate(project)

    let file_regex = '**/'.a:project.'/settings.py'
    let file = split(globpath(g:django_projects, file_regex))[0]
    let g:project_directory = fnamemodify(file, ':h:h')
    let env_module  = a:project.".settings"
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
        if exists('g:loaded_nerd_tree')
            exec ':NERDTree '.g:project_directory
        endif
    endif

python << EOF
import vim
import sys
import os

os.environ['DJANGO_SETTINGS_MODULE'] = vim.eval('env_module')
directory = vim.eval('g:project_directory')
sys.path.append(directory)

EOF
if ('g:django_set_workdir')
    if g:django_set_workdir = 1
        chdir g:project_directory
    endif
endif

endfunction
