augroup vimrc
  autocmd!
augroup END

" --------- general settings ---------
filetype plugin indent on
set timeoutlen=1000 ttimeoutlen=0
set fileencoding=utf-8 encoding=utf-8 fileformat=unix
set ambiwidth=double
set clipboard=unnamed
set ttyfast
set hidden
set list
set nobackup noswapfile nowritebackup
set autoread
set showcmd
set laststatus=2
set ignorecase smartcase
set nrformats= " disable nrformats=octal,hex
set incsearch hlsearch
set completeopt=menuone,preview pumheight=10
set wrap display=lastline
set backspace=eol,indent,start
set ruler number
set history=500
set wildmenu wildmode=list:full wildignore=*.o,*.obj,*.pyc,*.so,*.dll
set shiftwidth=2 softtabstop=2 tabstop=2 smarttab expandtab
set smartindent autoindent
set showmatch matchtime=1
set undolevels=100
set scrolloff=3
set mouse=n

" ----------- key mapping --------- 
let g:mapleader = "\<Space>"

nnoremap j gj
nnoremap k gk

noremap <C-J> :bnext<CR>
noremap <C-K> :bprev<CR>

" avoid overwriting register when paste text at visual mode
xnoremap <expr> p 'pgv"'.v:register.'y`>'

nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

cnoremap w!! w !sudo tee > /dev/null %

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

" move line up and down
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" --------- plugin settings ---------

if filereadable(expand('$HOME/dotfiles/vim/plugins.vim'))
  source $HOME/dotfiles/vim/plugins.vim
endif
