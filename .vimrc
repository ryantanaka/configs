" plugin 
execute pathogen#infect()

" stuff to get true color
if (has("termguicolors"))
    set termguicolors
endif

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

syntax on
syntax enable
set background=dark
colorscheme solarized

" change bracket match color
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" show the ruler
set ruler
