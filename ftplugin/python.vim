function! s:CreateRelatedMappingsPerFile(filename)
    let methods = ['tab', 'vsplit', 'split']

    for method in methods
        execute 'nmap r'.a:filename[:0].method[:0].' :call django#apps#edit("'.a:filename.'", "'.method.'")<CR>'
    endfor
endfunction

call s:CreateRelatedMappingsPerFile('models.py')
call s:CreateRelatedMappingsPerFile('views.py')
call s:CreateRelatedMappingsPerFile('urls.py')
call s:CreateRelatedMappingsPerFile('tests.py')
call s:CreateRelatedMappingsPerFile('admin.py')
