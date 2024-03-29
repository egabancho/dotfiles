set nocompatible " be iMproved always

let mapleader = "\<Space>" " use same leader as emacs and don't drive me crazy!

"================ BackUp and Undo ==============

set noswapfile
set nobackup
set nowb
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if version >= 703
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" =============== Main Config ===============
set autoread                    "Reload files changed outside vim
set number                      "Line numbers are good
set cursorline                  "Line to indicate the cursor location
set backspace=indent,eol,start  "Allow backspace in insert mode
set mouse=a                     "Allow mouse in all modes
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end
set clipboard=unnamed           "Support for Mac OS X clipboard
set pastetoggle=<F2>            "Paste mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set synmaxcol=2048

"turn on syntax highlighting
syntax enable

" spell checking
set spell
" Toggle spell checking on and off with `Space-s`
nmap <silent> <leader>s :set spell!<CR>
" Set region to US English
set spelllang=en_us

"change the current dir to file path unless working on /tmp
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

"Force Saving Files that Require Root Permission
cmap w!! %!sudo tee > /dev/null %

" ask before leaving with unsaved changes
set confirm

" map . in visual mode
vnoremap . :norm.<cr>

" ================ Copy & paste  =================
 vmap <C-c> "+yi
 vmap <C-x> "+c
 vmap <C-v> c<ESC>"+p
 imap <C-v> <ESC>"+pa

" ================ Search Settings  =================

set ignorecase
set smartcase
set hlsearch
set incsearch        "Find the next match as we type the search
set hlsearch         "Highlight searches by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
" clear the command line and search highlighting
noremap <silent><leader>/ :nohlsearch<CR>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

map <leader>g :grep

" map Silver Searcher
map <leader>a :Ag!<space>

" search for word under cursor with Silver Searcher
map <leader>A :Ag! "<C-r>=expand('<cword>')<CR>"

" bind K to grep word under cursor
nnoremap <leader>gg :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" ================ Indentation ======================

" (un)indent
vnoremap < <gv
vnoremap > >gv

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set copyindent

" make backspaces more powerfull
set backspace=indent,eol,start

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:▸\ ,trail:·
set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" use Q for formatting the current selection or paragraph
vmap Q gq
nmap Q gqap

autocmd Filetype xml,bib,text,tex,plaintex,html,js setlocal ts=2 sts=2 sw=2

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

" ================ Colors  =================
set background=dark

" ================ Navigation ============================

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
set hidden
set switchbuf=useopen

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

map <leader>[ :bp<CR>
map <leader>] :bn<CR>
map <leader>q :bp <BAR> bd #<CR>
nnoremap <C-h> :bp<CR>
nnoremap <C-l>   :bn<CR>
inoremap <C-h> <Esc>:bp<CR>i
inoremap <C-l>   <Esc>:bn<CR>i

" ================ Completion =======================

set completeopt=longest,menuone
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll trough matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pyc
" Autocompletion
autocmd BufEnter * :syntax sync fromstart
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow"

" ================ Scrolling & Line and ColumnNumbers ========================

set scrolloff=4         "Start scrolling when we're 4 lines away from margins
set sidescrolloff=15
set sidescroll=1

" toggle line numbers
set number
set relativenumber
nnoremap <leader>l :set norelativenumber!<CR>
nnoremap <leader>ll :set invnumber<CR>
