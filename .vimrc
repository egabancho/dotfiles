" =============== Main Config ===============
set nocompatible              " be iMproved, required
autocmd! bufwritepost .vimrc source ~/.vimrc
autocmd! bufwritepost vimrc source ~/.vimrc
let mapleader=","

" =============== Vundle ===============
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" =============== Plugins ===============
" Color schemes
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
" Fuzzy file, buffer, mru, tag, etc. finder
Plugin 'kien/ctrlp.vim'
" A cosa completion engine
Plugin 'Valloric/YouCompleteMe'
" Syntax checking hacks
Plugin 'scrooloose/syntastic'
" A tree explorer
Plugin 'scrooloose/nerdtree'
" Displays tags in a window, ordered by scope
Plugin 'majutsushi/tagbar'
" The ultimate snippet solution + default snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" allows you to use <Tab> for all your insert completion needs
Plugin 'ervandew/supertab'
" Much simpler way to use some motions in vim
Plugin 'Lokaltog/vim-easymotion'
" All about surroundings: parentheses, brackets, quotes, XML tags
Plugin 'tpope/vim-surround'
" Visualize vim undo tree
Plugin 'sjl/gundo.vim'
" File-type sensible comments
Plugin 'tomtom/tcomment_vim'
" Better Rainbow Parentheses
Plugin 'kien/rainbow_parentheses.vim'
" Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-fugitive'
" Provides insert mode auto-completion for quotes, parens, brackets, etc.
Plugin 'Raimondi/delimitMate'
" Visually displaying indent levels in code
Plugin 'nathanaelkane/vim-indent-guides'
" Lean & mean status/tabline that's light as air
Plugin 'bling/vim-airline'
" Script for text filtering and alignment
Plugin 'godlygeek/tabular'
" Python virtualenv
Plugin 'jmcantrell/vim-virtualenv'
" Sublime Text style multiple selections
Plugin 'terryma/vim-multiple-cursors'
" Visually select increasingly larger regions of text
Plugin 'terryma/vim-expand-region'
" Syntax highlighting, indenting and autocompletion for LESS
Plugin 'groenewege/vim-less'
" Vimscript for gist
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
" Markdown
Plugin 'tpope/vim-markdown'
" tmux integration
Plugin 'edkolev/tmuxline.vim'
Plugin 'christoomey/vim-tmux-navigator'
" ACK inside vim
Plugin 'mileszs/ack.vim'
" Javascript indentation and syntax support
Plugin 'pangloss/vim-javascript'
Plugin 'Shutnik/jshint2.vim'
" Better CSS Syntax for Vim
Plugin 'hail2u/vim-css3-syntax'

filetype plugin indent on     " required
filetype on

" ================ General Config ====================

set autoread                    "Reload files changed outside vim
set number                      "Line numbers are good
set cursorline                  "Line to indicate the cursor location
set backspace=indent,eol,start  "Allow backspace in insert mode
set mouse=a                     "Allow mouse in all modes
set ttymouse=xterm2
set clipboard=unnamedplus       "Support for Mac OS X clipboard
set pastetoggle=<F2>            "Paste mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set synmaxcol=2048

"turn on syntax highlighting
syntax on

set spell
" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>
" Set region to US English
set spelllang=en_us

"make :! work with aliases
set shellcmdflag=-ic

" set xterm title
set title

" access the yank registers
map <leader>r :reg<CR>


"change the current dir to file path unless working on /tmp
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

"Force Saving Files that Require Root Permission
" Maybe worth trying chrisbra/SudoEdit.vim
cmap w!! %!sudo tee > /dev/null %

" Set tag file, search for the file named 'tags', starting with the directory
" of the current file and then going to the parent directory and then
" recursively to the directory one level above, till it either locates the
" 'tags' file
" http://vim.wikia.com/wiki/Browsing_programs_with_tags
set tags=./tags;

" remember cursor and buffers states
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=%
set nostartofline

" ask before leaving with unsaved changes
set confirm

" map . in visual mode
vnoremap . :norm.<cr>

" ================ Copy & paste  =================
 vmap <C-c> "+yi
 vmap <C-x> "+c
 vmap <C-v> c<ESC>"+p
 imap <C-v> <ESC>"+pa

" ================ Colors  =================
syntax enable
set background=dark
colorscheme solarized

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
nnoremap <silent> <leader><space> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" hint to keep lines short
if exists('+colorcolumn')
  set colorcolumn=80
endif

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


" ================ BackUp and Undo ==============

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

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "don't fold by default

" ================ Navigation ============================

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
set hidden
set switchbuf=useopen

map <leader>[ :bp<CR>
map <leader>] :bn<CR>
map <leader>q :bp <BAR> bd #<CR>
nnoremap <C-h> :bp<CR>
nnoremap <C-l>   :bn<CR>
inoremap <C-h> <Esc>:bp<CR>i
inoremap <C-l>   <Esc>:bn<CR>i
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

let c = 1
while c <= 99
  execute "nnoremap " . c . "gb :" . c . "b\<CR>"
  let c += 1
endwhile

" Merge a tab into a split in the previous window
function! MergeTabs()
  if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif
  vsplit
  execute "buffer " . bufferName
endfunction

nmap <C-W>u :call MergeTabs()<CR>

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

