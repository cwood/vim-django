call NERDTreeAddMenuSeparator()

call NERDTreeAddMenuItem({
    \ 'text': '(dj)ango app',
    \ 'shortcut': 'dj',
    \ 'callback': 'django#plugins#nerdtree_create',
    \ 'isActiveCallback': 'django#is_active' })
