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

    if !exists('g:django_projects_search_exp')
        let g:django_projects_search_exp = '**'  " Recursivly look down for all settings
    endif

    let search_exp = g:django_projects_search_exp . "/" . a:project . "/settings*"

    if !exists('g:django_projects')
        echoerr "No django projects directory set. Please set one"
        return
    endif

    let settings_found = split(globpath(g:django_projects, search_exp))[0]

    if len(settings_found) == 0
        echoerr "No settings file found"
        return
    endif

    if isdirectory(l:settings_found)
        let g:django_project_directory = fnamemodify(l:settings_found, ':h:h')
    else
        let g:django_project_directory = fnamemodify(l:settings_found, ':p:h:h')
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
    else
        exec "cd " . g:django_project_directory
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

python << EOI
from django.utils.importlib import import_module
from django.template.loaders.app_directories import app_template_dirs
from django.conf import settings
import vim
for template_dir in app_template_dirs:
    vim.command("exec 'set path+=%s'" % (template_dir))

for app in settings.INSTALLED_APPS:
    try:
        mod = import_module(app)
    except ImportError, e:
        raise ImproperlyConfigured('ImportError %s: %s' % (app, e.args[0]))
    static_dir = os.path.join(os.path.dirname(mod.__file__), 'static')
    if os.path.isdir(static_dir):
        vim.command("exec 'set path+=%s'" % (static_dir))
EOI



    command! -nargs=? -complete=customlist,django#completions#managmentcommands DjangoManage call django#commands#manage(<q-args>)
    command! -nargs=? -complete=customlist,django#completions#managmentcommands DjangoAdmin call django#commands#admin(<q-args>)
    command! -nargs=? -complete=customlist,django#completions#pypath DjangoCreateApp call django#apps#create_app(<q-args>)

endfunction
