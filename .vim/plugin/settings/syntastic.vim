map <leader>e :Errors<CR>

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height=5
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pep8', 'pep257', 'pylint']

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

nnoremap <leader>ss :SyntasticCheck<CR>
function! ToggleErrors()
    if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
         " No location/quickfix list shown, open syntastic error location panel
         Errors
    else
        lclose
    endif
endfunction
nnoremap <leader>se :<C-u>call ToggleErrors()<CR>
