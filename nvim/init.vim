" reset augroup
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
set cursorline cursorcolumn
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

" ----------- key mapping --------- 
"
" <Leader>をスペースキーにする
let g:mapleader = "\<Space>"

" file explorer setting.
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1
let g:netrw_altv=1
let g:netrw_winsize=20


" jj -> <ESC>
inoremap <silent> jj <ESC>
" move through wrapped one line
nnoremap j gj
nnoremap k gk
" get Y similar to D
nnoremap Y y$
" move to prev or next buffer
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
" deactivate highlight of search results when push esc key twice
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>
" w!! でスーパーユーザーとして保存
cnoremap w!! w !sudo tee > /dev/null %
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
" open vimrc
nnoremap <Leader>. :new ~/.config/nvim/init.vim<CR>

" -------- plugins settings ---------
call s:load('plugins')
