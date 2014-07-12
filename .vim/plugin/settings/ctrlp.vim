" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 'cra'

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

let g:ctrlp_show_hidden = 1

" Buffer explorer, useful in case we have way too many buffers open
nnoremap <Leader>b :CtrlPBuffer<CR>
