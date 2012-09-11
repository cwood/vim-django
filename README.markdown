Vim-Django
===============================================================================

Vim-Django is a ViM script that helps manage a django app(s). It has wrapping's
for the ``django-admin.py``, your projects ``manage.py`` and some helper
commands. It also has some quick ways to find templates, edit related files
in a app, create new apps, and help manage django while using ViM.


Commands
-------------------------------------------------------------------------------

``DjangoAdmin`` will run any command through the ``django-admin.py``
command.

``DjangoManage`` will run the management command for the project

``DjangoProjectActivate`` will activate the project. This will go through
your ``g:django_projects`` and find all the django projects. It will also
set up ``DJANGO_SETTINGS_MODULE`` in your environment and the directory
where the settings file is stored in your ``PYTHONPATH``.

``DjangoCreateApp`` will create a new app under your projects base. It will
autocomplete the path. It just needs is a python path such as,
``colinbits.apps.new_app`` this will be created in the folder colinbits,
apps, then run the ``django-admin.py`` to create the app there.



Mappings
-------------------------------------------------------------------------------

There are mappings for easily editing related django files while working on a
app. They all can be changed if you don't like how they are currently mapped.
There are mappings for (v|views), (u|urls), (a|admin),
and (t|tests). If you want to remap these you can call the function
``django#apps#edit('name_of_file.py', 'split')`` and it will open up
the file it fines in a split.


Configuration
-------------------------------------------------------------------------------

``g:django_projects`` is where your django projects are located.

``g:django_activate_virtualenv`` when true will activate a virtualenv that
starts with the same name. An example being. colinbits, is the site, and the
virtualenv being colinbits.com.


Custom Activation of Projects
-------------------------------------------------------------------------------

Since not everyone uses the default settings file vim-django will allow you to
add a custom function to activate any project. In your vimrc you can define a
function called ``ActivateProject`` it needs to accept one argument. From here
you can have it activate the project.

Working with other Scripts
-------------------------------------------------------------------------------

NERDTree:
    ``g:django_activate_nerdtree`` when set to 1 will launch nerdtree when
    activating the django project.

VirtualEnv:
    ``g:django_activate_virtualenv`` when set to 1 will activate the virtual
    env that starts with the same name.


Installing
-------------------------------------------------------------------------------

I recommend using pathogen or vundle to install this script. Else, you can
put the ``django.vim`` in the plug-ins directory. This script does require
python to be compiled in.

Example .vimrc
------------------------------------------------------------------------------
```vim
let g:django_projects = '~/Projects' "Sets all projects under project
let g:django_project_container = 'source' "Inside of these folders look for source
let g:django_activate_virtualenv = 1 "Try to activate the associated virtualenv
let g:django_activate_nerdtree = 1 "Try to open nerdtree at the project root.
```

Screen shots
-------------------------------------------------------------------------------

![Mangement Command](http://i.imgur.com/NYd9d.png)


FAQ
------------------------------------------------------------------------------

* Working with virtualenv's
    * I actully reccomend installing [vim-virtualenv](https://github.com/jmcantrell/vim-virtualenv)
