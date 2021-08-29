" kPLUGINS #####################################################################
" setup vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" gruvbox color scheme
Plug 'morhetz/gruvbox'

" View man pages from vim.
" Usage: 
"   :Man <command> <-- horizontal split, you can tab complete on command
"   :Vman <command> <-- vertical split 
"   g/ <-- option search 
Plug 'vim-utils/vim-man'

" Recursively search directories for a regex pattern.
" Usage:
"   :Rg <pattern>
Plug 'jremmen/vim-ripgrep'

" Plug 'Valloric/YouCompleteMe'
" TODO: address later 
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

" COLORSCHEME #################################################################
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark='(medium)'

" CONFIGURATION ###############################################################
syntax on 
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set colorcolumn=80
set cursorline

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

" set movement amongst splits
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" convenient project search
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>ps :Rg<SPACE>

" vertical resizing 
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

