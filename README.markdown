Django Vim
===============================================================================

Django vim wraps the manage.py and will allow vim to work with your project.

Commands
-------------------------------------------------------------------------------

``DjangoManage`` will run the management command for the project

``DjangoProjectActivate`` will activate the project. This will go through
your ``g:django_projects`` and find all the django projects. It will also
set up ``DJANGO_SETTINGS_MODULE`` in your environment and the directory
where the settings file is stored in your ``PYTHONPATH``.


Mappings
-------------------------------------------------------------------------------

TODO


Configuration
-------------------------------------------------------------------------------

``g:django_projects`` is where your django projects are located.

``g:project_apps`` is where apps are created by default. This is still left
to do. The idea is when ``DjManage createapp killerapp`` it will create it
in your preferred directory.


Installing
-------------------------------------------------------------------------------

I recommend using pathogen or vundle to install this script. Else, you can
put the ``django.vim`` in the plug-ins directory. This script does require
python to be compiled in.

Screen shots
-------------------------------------------------------------------------------

![Mangement Command](http://i.imgur.com/WWEy9.png)


FAQ
------------------------------------------------------------------------------

* Working with virtualenv's
    * I actully reccomend installing [vim-virtualenv](https://github.com/jmcantrell/vim-virtualenv)
