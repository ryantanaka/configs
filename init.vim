" PLUGINS #####################################################################
call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'sainnhe/gruvbox-material'
" gcc to comment line (takes a count)
" gc to comment out target of motion (or in visual mode)
" use same operation to uncomment
Plug 'tpope/vim-commentary'

" Plug 'mbbill/undotree'
call plug#end()

" setup autopairs to autocomplete ({[ etc
lua require('nvim-autopairs').setup{}

" COLORSCHEME #################################################################
if has('termguicolors')
  set termguicolors
endif

let g:gruvbox_material_background='medium'
let g:gruvbox_material_palette='material'
colorscheme gruvbox-material

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

" turn of highlights (after searching)
nnoremap <silent><leader>h :noh<CR>

" toggle number and relativenumber
:function ToggleLineNumbers()
: set number!
: set relativenumber!
:endfunction

" toggle number and relative number shortcut
nnoremap <silent><leader>r :call ToggleLineNumbers()<CR>

" set indent guide to off by default
let g:indent_blankline_enabled = v:false
" toggle indent guide
nnoremap <silent><leader>i :IndentBlanklineToggle<CR>

" start up Goyo (focus mode) 
nnoremap <silent><leader>g :Goyo<CR> :call ToggleLineNumbers()<CR>

" open file tree
nnoremap <leader>t :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" convenient buffer switching (hit TAB to cycle through tabs)
nnoremap <leader>b :b<SPACE>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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

" tree-sitter syntax highlighting
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


