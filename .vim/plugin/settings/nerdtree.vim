" Open/Hide NerdTree
autocmd VimEnter * nmap <F3> :NERDTreeToggle<CR>
autocmd VimEnter * imap <F3> <Esc>:NERDTreeToggle<CR>a
let NERDTreeWinSize=35
" let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeWinPos="left"
let NERDTreeShowLineNumbers=0
" disable buffer delete in NERDTree
autocmd FileType nerdtree cnoreabbrev <buffer> bd <nop>
