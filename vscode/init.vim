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
highlight ColorColumn ctermbg=7
set backspace=indent,eol,start
set relativenumber
set ruler
set number
set incsearch

" set leader key to be SPACEBAR
let mapleader=" "

" turn off highlights (after searching)
nnoremap <silent><leader>h :noh<CR>

" toggle number and relativenumber
:function ToggleLineNumbers()
: set number!
: set relativenumber!
:endfunction

" toggle number and relative number shortcut
nnoremap <silent><leader>r :call ToggleLineNumbers()<CR>

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


