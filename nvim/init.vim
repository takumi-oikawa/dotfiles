augroup initvim
  autocmd!
augroup END

function! s:load(file) abort
    let s:path = expand('$XDG_CONFIG_HOME/nvim/rc/' . a:file . '.vim')

    if filereadable(s:path)
        execute 'source' fnameescape(s:path)
    endif
endfunction

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
set incsearch hlsearch inccommand=split
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

" ----------- filetype indent -----------

autocmd initvim BufNewFile,BufRead *.elm setlocal tabstop=4 softtabstop=4 shiftwidth=4

" ----------- key mapping --------- 

let g:mapleader = "\<Space>"

inoremap <silent> jj <ESC>

nnoremap j gj
nnoremap k gk

nnoremap Y y$

noremap <C-J> :bnext<CR>
noremap <C-K> :bprev<CR>

" avoid overwriting register when paste text at visual mode
xnoremap <expr> p 'pgv"'.v:register.'y`>'

" search on visual mode
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

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

nnoremap Q  q
nnoremap M  m

nnoremap <Leader>t :hi Normal guibg=NONE ctermbg=NONE<CR>
nnoremap <Leader>T :set background=dark<CR>

nnoremap <Leader>. :e ~/.config/nvim/init.vim<CR>

" move line up and down
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" -------- plugins settings ---------
call s:load('plugins')
