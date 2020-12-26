
call plug#begin()

Plug 'tpope/vim-surround'

Plug 'junegunn/vim-easy-align'

" disable bad plugins
let g:polyglot_disabled = ['markdown', 'csv']
Plug 'sheerun/vim-polyglot'

Plug 'vim-scripts/bats.vim'

Plug 'junegunn/goyo.vim', { 'for': 'markdown' }

Plug 'mechatroner/rainbow_csv'

Plug 'honza/vim-snippets'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"
" ------ vim-easy-align ------
"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"
" ------ vim-polyglot ------
"

au BufRead,BufNewFile *.sbt set filetype=scala

autocmd vimrc FileType json syntax match Comment +\/\/.\+$+

"
" ------ coc-nvim ------
"

source $HOME/dotfiles/vim/coc.vim
