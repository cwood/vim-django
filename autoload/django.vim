" django.vim - A bangin' interface for ViM and Django
" Maintainer: Colin Wood <cwood06@gmail.com>
" Version: 0.2.0a
" License: Same as ViM. see http://www.gnu.org/licenses/vim-license.txt

function! s:GetInstalledApps(prefix, ...)
python << EOF
from django.conf import settings
vim.command('return '+str(settings.INSTALLED_APPS))
EOF
endfunction

function! django#CreateNewApp(args)
    call s:CreateNewApp(a:args)
endfunction

function! django#InstalledApps(arg_lead, ...)
    return s:GetInstalledApps(a:arg_lead)
endfunction
