if exists('g:loaded_nerd_tree')
function! django#plugins#nerdtree_create()
    let curDirNode = g:NERDTreeDirNode.GetSelected()

    let newDjangoName = input("Add a django-app\n".
      \ "==========================================================\n".
      \ "Enter the django-app name to be created. \n".
      \ "==> ")

    exec 'chdir ' . curDirNode.path.str()
    call django#commands#manage('startapp '.newDjangoName)
endfunction
endif
