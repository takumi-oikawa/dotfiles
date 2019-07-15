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
" set character code to utf-8
set fenc=utf-8
set encoding=utf-8
" 改行コードの自動判別
set fileformat=unix
" □や○文字が崩れる問題を解決
set ambiwidth=double
" 編集中でも別のファイル開ける
set hidden
" 高速スクロール支援
set ttyfast
" do not save backup and swap files
set nobackup
set noswapfile
set nowritebackup
" automatically reload file when updated by other application
set autoread
" show currently typing command
set showcmd
" show current line and column
set cursorline
set cursorcolumn
" show status lines 
set laststatus=2
" ignore case when searching on lower cases, but do not on upper case
set ignorecase
set smartcase
" Deal as digits for any numberical object when using <C-x><C-a>
set nrformats=
" incremental search
set incsearch
" highlight search results
set hlsearch
" 補完ウィンドウの設定
set completeopt=menuone
" do not wrap text
set nowrap
set display=lastline
" enable backspace
set backspace=eol,indent,start
" show line number and percentage
set ruler
" show line number
set number
" show unvisible character
set list
" command history max capacity
set history=500
" コマンドラインの補完拡張
set wildmenu
set wildmode=list:full
set wildignore=*.o,*.obj,*.pyc,*.so,*.dll
" Use OS clipboard
set clipboard=unnamed
" 自動インデントでずれる幅
set shiftwidth=2
" 連続した空白に対してタブキーやbackspaceでカーソルが動く幅
set softtabstop=2
" 画面上でタブ文字がしめる幅
set tabstop=2
" smart tab & indent
set smarttab
set smartindent
" autoindent
set autoindent
" tab becomes white spaces
set expandtab
" suggestion window size
set pumheight=10
" brace match
set showmatch
set matchtime=1

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
" Better x
nnoremap x "_x
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
