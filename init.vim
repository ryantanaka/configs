" PLUGINS #####################################################################
call plug#begin('~/.vim/plugged')
" gruvbox color scheme
Plug 'morhetz/gruvbox'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'mbbill/undotree'
call plug#end()

" COLORSCHEME #################################################################
colorscheme gruvbox
set termguicolors
set background=dark
let g:gruvbox_contrast_dark='(medium)'

" CONFIGURATION ###############################################################
syntax on 
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set smartcase
set noswapfile
set colorcolumn=80
set backspace=indent,eol,start
set relativenumber
set number

" keep an undo directory
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undodir
set undofile

" incremental search: while you search, you get results
set incsearch

" let RipGrep derive root from git project root
if executable('rg')
    let g:rg_derive_root='true'
endif

let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=25

" set leader key to be SPACEBAR
let mapleader=" "

" toggle number and relativenumber
:function ToggleLineNumbers()
: set number!
: set relativenumber!
:endfunction

nnoremap <leader>r :call ToggleLineNumbers()<CR>

" open file tree
nnoremap <leader>pt :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" ripgrep 
nnoremap <leader>ps :Rg<CR>

" fzf
" use TAB to select multiple files
" use CTRL-x to open selection in horizontal split
" use CTRL-v to open selection in vertical split
nnoremap <leader>pf :Files<SPACE>
nnoremap <leader>pg :GFiles<CR>

" convenient buffer switching (hit TAB to cycle through tabs)
nnoremap <leader>b :b<SPACE>

" set movement amongst splits
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" vertical resizing 
nnoremap <silent> <leader>+ :vertical resize +10<CR>
nnoremap <silent> <leader>- :vertical resize -10<CR>

" max out current vertical pane
nnoremap <silent><leader><bar> :wincmd <bar> <CR>

" max out current horizontal pane
nnoremap <silent><leader>_ :wincmd _ <CR>

" normalize panes
nnoremap <silent> <leader>= :wincmd = <CR>

" j,k store relative line number jumps in the jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

