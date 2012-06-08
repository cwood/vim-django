Django Vim
===============================================================================

Django vim wrappes the manage.py and will allow vim to work with youre project.

Commands
-------------------------------------------------------------------------------

``DjManage`` will run the managment command for the project

``DjangoProjectActivate`` will activate the project. This will go through
your ``g:django_projects`` and find all the django projects. It will also
set up ``DJANGO_SETTINGS_MODULE`` in youre enviroment and the directory
where the settings file is stored in your ``PYTHONPATH``.


Configuration
-------------------------------------------------------------------------------

``g:django_projects`` is where youre django projects are located.

``g:project_apps`` is where apps are created by default. This is still left
to do. The idea is when ``DjManage createapp killerapp`` it will create it
in your preferred directory.


Screenshots
------------------------------------------------------------------------------

![Mangement Command](http://i.imgur.com/WWEy9.png)