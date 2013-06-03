if !exists('*ActivateProject')
function! ActivateProject(project)
python << EOF
import vim
import sys
import os

os.environ['DJANGO_SETTINGS_MODULE'] = vim.eval('a:project')+'.settings'
sys.path.append(vim.eval('g:django_project_directory'))
EOF
endfunction
endif

function! django#project#activate(project)

    if exists('g:django_project_container')
        let file_regex = '*/'.g:django_project_container.'/'.a:project.'/settings*'
    else
        let file_regex = a:project.'/settings*'
    endif

    let settings = split(globpath(g:django_projects, file_regex))[0]

    if isdirectory(l:settings)
        let g:django_project_directory = fnamemodify(l:settings, ':h:h')
    else
        let g:django_project_directory = fnamemodify(l:settings, ':p:h:h')
    endif

    let g:django_project_name = a:project

    if exists('g:django_activate_virtualenv')
        if exists('g:virtualenv_loaded') && g:django_activate_virtualenv == 1
            for env in virtualenv#names(a:project)
                call virtualenv#activate(env)
                break
            endfor
        else
            echoerr 'VirtualEnv not installed. Not activating.'
        endif
    endif

    if exists('g:django_activate_nerdtree')
        if exists('g:loaded_nerd_tree') && g:django_activate_nerdtree == 1
            exec ':NERDTree '.g:django_project_directory
        else
            echoerr "NERDTree not installed. Can not open."
        endif
    endif

    exec 'set path+='.expand(g:django_project_directory)
    call ActivateProject(a:project)

    let template_dirs = split(globpath(g:django_project_directory, '**/templates'))
    for template_dir in template_dirs
        exec 'set path+='.expand(template_dir)
    endfor

    let static_dirs = split(globpath(g:django_project_directory, a:project . '/**/static'))
    for static_dir in static_dirs
        exec 'set path+='.expand(static_dir)
    endfor

    command! -nargs=? -complete=customlist,django#completions#managmentcommands DjangoManage call django#commands#manage(<q-args>)
    command! -nargs=? -complete=customlist,django#completions#managmentcommands DjangoAdmin call django#commands#admin(<q-args>)
    command! -nargs=? -complete=customlist,django#completions#pypath DjangoCreateApp call django#apps#create_app(<q-args>)

endfunction
