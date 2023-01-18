call plug#begin(expand('~/.config/nvim/plug/'))

" Language support
Plug 'vim-scripts/c.vim'
Plug 'godlygeek/tabular' 
" gives me for example gruvbox
Plug 'flazz/vim-colorschemes'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-autoformat/vim-autoformat'

" For occasions
" Plug 'ntpeters/vim-better-whitespace' " does highlight trailing spaces in red

call plug#end()

"colorscheme
colorscheme gruvbox     " define syntax color scheme
" basics
let mapleader = ","     " map leader to ,
set mouse=a             " make sure mouse is used in all cases.
set t_Co=256            " set 256 color
set background=dark
set shortmess+=I        " disable the welcome screen
set clipboard+=unnamedplus  " yank and copy to X clipboard
set backspace=2         " full backspacing capabilities
set history=100         " 100 lines of command line history
set ruler               " ruler display in status line
set hidden              " enable buffer switching without saving
set showmode            " show mode at bottom of screen
set cmdheight=1         " set the command height
set showmatch           " show matching brackets (),{},[]
set mat=10               " show matching brackets for 0.5 seconds
set number              " show line numbers

" Filetype detection
filetype on
filetype plugin on
filetype indent on
syntax on               " enable syntax highlighting

"Rebinds
"" Move between windows with strg + hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"" Disable arrowkey everywhere
nnoremap <Up> :echo "No left for you!"<CR>
vnoremap <Up> :<C-u>echo "No left for you!"<CR>
inoremap <Up> <C-o>:echo "No left for you!"<CR>

nnoremap <Down> :echo "No left for you!"<CR>
vnoremap <Down> :<C-u>echo "No left for you!"<CR>
inoremap <Down> <C-o>:echo "No left for you!"<CR>

nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
inoremap <Left> <C-o>:echo "No left for you!"<CR>

nnoremap <Right> :echo "No left for you!"<CR>
vnoremap <Right> :<C-u>echo "No left for you!"<CR>
inoremap <Right> <C-o>:echo "No left for you!"<CR>


"remove highlighing
set nocursorline        " don't highlight cursor line (this makes scrolling slow)
set nocursorcolumn      " don't highlight cursor column (breaks completion preview)

" Indents word-wrapped lines as much as the 'parent' line

" backup settings
set noswapfile          " don't create a swap file
set nobackup            " don't keep a backup file
set backupdir=/tmp      " backup dir
set directory=/tmp      " swap file directory

" tabs and indenting and trail spaces
"" Tab
set expandtab           " insert spaces instead of tab chars
set tabstop=4           " a n-space tab width
set shiftwidth=4        " allows the use of < and > for VISUAL indenting
set softtabstop=4       " counts n spaces when DELETE or BCKSPCE is used
""Indent
set autoindent          " auto indents next new line
set smarttab            " remember indent
""Trail
autocmd FileType c,cpp,java,php,py,fortran autocmd BufWritePre * %s/\s\+$//e
set breakindent
"" Ensures word-wrap does not split words
set formatoptions=l
set lbr

"Autocompletion
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

" command mode, changes the autocompletion suggestrion to be more
set wildmenu 
set wildmode=list:longest,full

" vim-autoformat
noremap <Leader>f :Autoformat<CR>

" tagbar
noremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>

inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"
set foldmethod=indent
" open fold with tab and move set line of fold to top of view
nnoremap <Tab> zOz<return><CR>
" use shift tab to close fold
nnoremap <S-Tab> zc 

autocmd BufNewFile,BufRead *.tex set spell
autocmd BufNewFile,BufRead *.txt set spell

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction                                                                                       
