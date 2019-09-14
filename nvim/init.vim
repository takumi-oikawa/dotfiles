" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" do not be vi compatibe
if &compatible
  set nocompatible
endif

function! s:load(file) abort
    let s:path = expand('$XDG_CONFIG_HOME/nvim/rc/' . a:file . '.vim')

    if filereadable(s:path)
        execute 'source' fnameescape(s:path)
    endif
endfunction

" --------- general settings ---------
filetype plugin indent on
set fileencoding=utf-8 encoding=utf-8 fileformat=unix
set ambiwidth=double
set clipboard=unnamed
set ttyfast
set hidden
set list
set nobackup noswapfile nowritebackup
set autoread
set showcmd
set cursorline cursorcolumn
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

" ----------- key mapping --------- 
"
" <Leader>をスペースキーにする
let mapleader = "\<Space>"
" jj -> <ESC>
inoremap <silent> jj <ESC>
" move through wrapped one line
nnoremap j gj
nnoremap k gk
" get Y similar to D
nnoremap Y y$
" move to prev or next buffer
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>
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
" deactivate highlight of search results when push esc key twice
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" w!! でスーパーユーザーとして保存
cmap w!! w !sudo tee > /dev/null %
" Allow normal CLI shortcut when command mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
" Disable Ex-mode.
nnoremap Q  q
" Useless command.
nnoremap M  m
" centering when search
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz

" -------- plugins settings ---------
call s:load('plugins')
