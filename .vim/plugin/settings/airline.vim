" Show status line
set laststatus=2

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Show buffer numbers
let g:airline#extensions#tabline#buffer_nr_show = 1

" Enable tmux integration
let g:airline#extensions#tmuxline#enabled = 0

" Powerline patched fonts
let g:airline_powerline_fonts = 1

" Enable virtualenv
let g:airline#extensions#virtualenv#enabled = 1
