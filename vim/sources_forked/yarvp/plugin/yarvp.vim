" --------------------------------
" Add our plugin to the path
" --------------------------------
python import sys
python import os
python import vim
python sys.path.append(os.path.join(vim.eval('expand("<sfile>:h")')))

" --------------------------------
"  Function(s)
" --------------------------------
function! TemplateExample()
python << endOfPython

from yarvp import template_example

for n in range(5):
    print(template_example())

endOfPython
endfunction

" --------------------------------
"  Expose our commands to the user
" --------------------------------
command! Example call TemplateExample()
