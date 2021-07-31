" === PLUGINS === "
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'rakr/vim-one'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'

Plug 'alvan/vim-closetag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tmhedberg/matchit'

Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'

Plug 'stephenway/postcss.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'tuanpham-dev/vim-liquid'
Plug 'tuanpham-dev/vim-html-indent'

call plug#end()

" === CONFIGURATION === "

" Basic
set nocompatible
set noerrorbells
set belloff=all
set mouse=a
set encoding=UTF-8
set fileformat=unix
set noswapfile
set smartcase
set nowrap
set whichwrap+=<,>,[,]
set backspace=indent,eol,start
set incsearch
set number
set relativenumber
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set scrolloff=5
set splitbelow splitright
set wildmenu

" Backup
set backup
set backupdir=~/.config/nvim/backups
set writebackup
set backupcopy=yes
autocmd BufWritePre & let &bex = '@' . strftime("%F.%H:%M")

" Indentation
filetype on
filetype plugin on
filetype indent on

" Custom indetation for file types
autocmd Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Leave insert mode when inactive
autocmd CursorHoldI * stopinsert

" Enter insert mode on new terminal created
autocmd TermOpen term://* startinsert
autocmd BufEnter, BufNew term://* startinsert

" Appearance
syntax on
silent! colorscheme one

set t_Co=256
set cursorline
set background=dark
let g:one_allow_italics=1

if (has('termguicolors'))
  set termguicolors
endif

let g:indent_blankline_char_highlight_list = [ 'IndentGuides' ]
let g:indent_blankline_char = '|'
let g:indent_blankline_space_char = ' '
let g:indent_blankline_show_trailing_blankline_indent = v:false

autocmd VimEnter,Colorscheme * :highlight IndentGuides guifg=#343845 guibg=NONE

set laststatus=2
set noshowmode

let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \             [ 'percent' ],
  \             [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ }
  \ }

" editorconfig
let g:EditorConfig_exclude_patterns = ['figutive://.*', 'scp://.*']

" === Startup Page === "
let g:startify_session_dir = '~/.config/nvim/sessions'
let g:startify_session_delete_buffers = 1
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 0
let g:startify_lists = [
  \ { 'type': 'sessions', 'header': ['    Projects'] },
  \ { 'type': 'dir', 'header': ['    Recent Files'] }
  \ ]

autocmd SessionLoadPost * stopinsert

" === File Browser === "

" NERDTree
let NEARDTreeMinimalUI = 1
autocmd BufEnter * if tabpagenr('$') == 1
  \ && winnr('$') == 1
  \ && exists('b:NERDTree')
  \ && b:NERDTree.isTabTree()
  \ | quit | endif
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
let g:NERDTreeShowHidden = 1

" Fuzzy finder
let g:fzf_height = '70%'
let $FZF_DEFAULT_OPTS = "--preview 'bat --color=always'"

function FZFiles()
  execute (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')
endfunction

command! FZFiles call FZFiles()

" === KEY MAPPING === "

" Set leader key to space
let mapleader = ' '

" Clear search highlight with <esc>
noremap <silent><esc> :noh<cr>

" Session
noremap <leader>ls :SSave!<cr>
noremap <leader>ll :SClose<cr>

" Clipboard
noremap <leader>c '*yy<cr>'
noremap <leader>v '+p<cr>'

" Pane
noremap <leader>ws <C-w>s
noremap <leader>wv <C-w>v
noremap <leader>wc <C-w>c
noremap <leader>ww <C-w>w
noremap <leader>WW <C-w>W
noremap <leader>== <C-w>5>
noremap <leader>-- <C-w>5<
noremap <leader>++ <C-w>5+
noremap <leader>__ <C-w>5-

tnoremap <leader>ww <C-\><C-n><C-w>w
tnoremap <leader>WW <C-\><C-n><C-w>W
tnoremap <leader>== <C-\><C-n><C-w>5>
tnoremap <leader>-- <C-\><C-n><C-w>5<
tnoremap <leader>++ <C-\><C-n><C-w>5+
tnoremap <leader>__ <C-\><C-n><C-w>5-

noremap <leader>1 1gt
noremap <leader>t gt
noremap <leader>T gT
tnoremap <leader>tt <C-\><C-n>gt
tnoremap <leader>TT <C-\><C-n>gT

" Terminal
noremap <leader>` :sp \| term<cr>
tnoremap <leader>`` <C-\><C-n>:vs \| term<cr>

" NERDTree
noremap <leader>e :NERDTreeTabsToggle<cr>

" Fuzzy Finder
noremap <leader>p :FZFiles<cr>
noremap <leader>P :Files<cr>
noremap <leader>fs :Rg<cr>

" Insert Mode Navigation
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Exit insert mode with jk
inoremap jk <esc>

" Move lines
nnoremap <A-j> :m .+1<cr>==
nnoremap <A-k> :m .-2<cr>==
inoremap <A-j> :m .+1<cr>==gi
inoremap <A-k> :m .-2<cr>==gi
vnoremap <A-j> :m '>+1<cr>gv=gv
vnoremap <A-k> :m '<-2<cr>gv=gv

" Add blank lines
noremap <leader>o o<cr><up>
noremap <leader>O O<cr><up>

" Comment line/selection
noremap <C-_> :Commentary<cr>
vnoremap <C-_> :Commentary<cr>

" === COC === "

" Snippets
inoremap <silent><expr> <tab>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" :
  \ <SID>check_back_space() ? "\<tab>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

inoremap <expr> <Tab> pumvisible() ? "\<down>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<up>" : "\<s-tab>"

inoremap <silent><expr> <c-space> pumvisible() ? "\<c-g>u": coc#refresh()
inoremap <silent><expr> <c-@> pumvisible() ? "\<c-g>u": coc#refresh()n
