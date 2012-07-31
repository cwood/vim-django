function! django#completions#pypath(prefix, ...)
python << EOB
import os
import vim
import sys

class NoMatchFound(Exception):
    pass

def create_prefix_paths(prefix):
    "Should return a list of items to compare aginst"

    if not prefix:
        paths = []
    else:
        try:
            paths = prefix.split('.')
        except AttributeError:
            paths = [prefix]
    return paths

def create_possible_paths(current_root, current_prefix):
    "Should take the prefix list and return a list of possible paths"

    if not isinstance(current_prefix, list):
        raise Exception('Prefix is not a list. What we gunna do!')

    full_path = os.path.join(current_root, *current_prefix)

    if not os.path.exists(full_path):
        if full_path == current_root:
            directories = _get_directories(current_root)
        else:
            base, head = os.path.split(full_path)
            directories = _get_directories(base)
    else:
        directories = _get_directories(full_path)

    paths = []

    if not current_prefix:
        begining_path = ''
    else:
        begining_path = '.'.join(current_prefix[:-1])
        matching = current_prefix[-1]

        if begining_path.startswith('.'):
            begining_path = begining_path[1:]

    for directory in directories:

        if begining_path and matching:
            if directory.startswith(matching):
                possible_path = begining_path+'.'+directory+'.'
                paths.append(possible_path)

        elif begining_path and not matching:
            possible_path = begining_path+'.'+directory+'.'
            paths.append(possible_path)
        else:
            possible_path = directory+'.'
            paths.append(possible_path)


    return paths

def _get_directories(path):

    directories = []
    for item in os.listdir(path):
        if os.path.isdir(os.path.join(path, item)) and not item.startswith('.'):
            directories.append(item)

    return directories

prefix = vim.eval('a:prefix')
project_root = vim.eval('g:project_directory')

prefix_path = create_prefix_paths(prefix)
possible_paths = create_possible_paths(project_root, prefix_path)

vim.command('return '+str(possible_paths))
EOB
endfunction


function! django#completions#managmentcommands(prefix, ...)
python << EOB
from django.core.management import get_commands

prefix = vim.eval('a:prefix')
commands = list(get_commands())

if prefix:
    commands = [command for command in commands if command.startswith(prefix)]

vim.command('return '+str(commands))
EOB
endfunction

function! django#completions#projectscomplete(prefix, ...)

    if exists('g:django_project_container')
        let file_regex = '*/'.g:django_project_container.'/*/settings.py'
    else
        let file_regex = '**/settings.py'
    endif

    let all_settings_files = split(globpath(g:django_projects, file_regex))
    let all_projects = []

    for setting_file in all_settings_files
        let project = fnamemodify(setting_file, ':h:t')
        call add(all_projects, project)
    endfor

    if a:prefix == ''
        return all_projects
    else
        let arg_regex = 'v:val =~ "'.a:prefix.'"'
        return filter(copy(all_projects), arg_regex)
    endif

endfunction

function! django#completions#installed_apps(prefix, ...)
python << EOB
import vim
from django.conf import settings
prefix = vim.eval('a:prefix')

if prefix:
    apps = [app for app in settings.INSTALLED_APPS if app.startswith(prefix)]
else:
    apps = settings.INSTALLED_APPS

vim.command('return'+str(apps))
EOB
endfunction
