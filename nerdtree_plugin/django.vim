if exists('g:django_nerdtree_plugin_loaded')
    finish
endif

let g:django_nerdtree_plugin_loaded = 1

call NERDTreeAddMenuSeparator()

call NERDTreeAddMenuItem({
    \ 'text': '(dj)ango app',
    \ 'shortcut': 'dj',
    \ 'callback': 'django#plugins#nerdtree_create',
    \ 'isActiveCallback': 'django#is_active' })
