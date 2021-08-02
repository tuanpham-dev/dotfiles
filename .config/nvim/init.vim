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
Plug 'peitalin/vim-jsx-typescript'
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
autocmd BufEnter,BufNew term://* startinsert

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
let g:startify_mapping_nowait = 1
let g:startify_session_sort = 0
let g:startify_session_number = 5
let g:startify_files_number = 5
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
noremap <silent> <esc> :noh<cr>

" Session
noremap <leader>ls :SSave!<cr>
noremap <leader>ll :SClose<cr>

" Clipboard
noremap <leader>c '*yy<cr>'
noremap <leader>v '+p<cr>'

" Pane
noremap <leader>= <c-w>5>
noremap <leader>- <c-w>5<
noremap <leader>+ <c-w>5+
noremap <leader>_ <c-w>5-
noremap <tab> <c-w>w
noremap <s-tab> <c-w>W

noremap <leader>1 1gt
noremap <leader>2 1gt
noremap <leader>3 1gt
noremap <leader>4 1gt
noremap <leader>5 1gt
noremap <leader>6 1gt
noremap <leader>7 1gt
noremap <leader>8 1gt
noremap <leader>9 1gt
noremap <leader>t gt
noremap <leader>T gT

" Terminal
tnoremap jk <c-\><c-n>
tnoremap <expr> <esc> (&filetype == 'fzf') ? '<esc>' : '<c-\><c-n>'
noremap <leader>` :sp \| term<cr>
tnoremap <leader>`` <c-\><c-n>:vs \| term<cr>

" NERDTree
noremap <leader>e :NERDTreeTabsToggle<cr>

" Fuzzy Finder
noremap <leader>p :FZFiles<cr>
noremap <leader>P :Files<cr>
noremap <leader>fs :Rg<cr>

" Insert Mode Navigation
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

" Exit insert mode with jk
inoremap jk <esc>

" Move lines
nnoremap <a-j> :m .+1<cr>==
nnoremap <a-k> :m .-2<cr>==
inoremap <a-j> :m .+1<cr>==gi
inoremap <a-k> :m .-2<cr>==gi
vnoremap <a-j> :m '>+1<cr>gv=gv
vnoremap <a-k> :m '<-2<cr>gv=gv
" -- MacOs - <opt-j>/<opt-k>
nnoremap ∆ :m .+1<cr>==
nnoremap ˚ :m .-2<cr>==
inoremap ∆ :m .+1<cr>==gi
inoremap ˚ :m .-2<cr>==gi
vnoremap ∆ :m '>+1<cr>gv=gv
vnoremap ˚ :m '<-2<cr>gv=gv

" Add blank lines
noremap <leader>o o<cr><up>
noremap <leader>O O<cr><up>

" Add comma to the end of current line and add blank line
noremap ,, A,<esc>o
inoremap <nowait> ,, <esc>A,<esc>o

" Comment line/selection
noremap <c-_> :Commentary<cr>
inoremap <c-_> :Commentary<cr>
vnoremap <c-_> :Commentary<cr>

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

inoremap <expr> <tab> pumvisible() ? "\<down>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<up>" : "\<s-tab>"

inoremap <silent><expr> <c-space> pumvisible() ? "\<c-g>u": coc#refresh()
inoremap <silent><expr> <c-@> pumvisible() ? "\<c-g>u": coc#refresh()n
" -- MacOs - map <c-space> to send å∫ç in iterm2
inoremap <silent><expr> å∫ç pumvisible() ? "\<c-g>u" : coc#refresh()
