Django Vim
===============================================================================

Django vim wraps the manage.py and will allow vim to work with your project.

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

TODO


Configuration
-------------------------------------------------------------------------------

``g:django_projects`` is where your django projects are located.


Installing
-------------------------------------------------------------------------------

I recommend using pathogen or vundle to install this script. Else, you can
put the ``django.vim`` in the plug-ins directory. This script does require
python to be compiled in.

Screen shots
-------------------------------------------------------------------------------

![Mangement Command](http://i.imgur.com/NYd9d.png)


FAQ
------------------------------------------------------------------------------

* Working with virtualenv's
    * I actully reccomend installing [vim-virtualenv](https://github.com/jmcantrell/vim-virtualenv)
