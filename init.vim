 " PLUGINS #####################################################################
call plug#begin()
Plug 'nvim-lua/plenary.nvim' " lua functions required by telescope and others
Plug 'nvim-telescope/telescope.nvim' " fuzzy search + ripgrep
Plug 'windwp/nvim-autopairs' " completes brackets, parenthesis, etc
Plug 'lukas-reineke/indent-blankline.nvim' " show indent guide
Plug 'tpope/vim-commentary' " gcc to cmt line (takes count), gc to comment target of motion (or visual)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " parser generater used by other plugins and themes
Plug 'nvim-treesitter/nvim-treesitter-context' " sticky scroll
Plug 'EdenEast/nightfox.nvim' " love this colorscheme!
Plug 'sainnhe/sonokai'
Plug 'folke/zen-mode.nvim' " focus mode (similar to Goyo)
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
call plug#end()

" COLORSCHEME #################################################################
set termguicolors
let g:sonokai_style = 'shusia'
colorscheme sonokai

" SETUP #######################################################################
lua require("zen-mode").setup{}
lua require("treesitter-context").setup{}
lua require('nvim-autopairs').setup{}
lua require("nvim-tree").setup{}
lua require("treesitter-context").setup{}

lua <<EOF
require('bufferline').setup {
    options = {
        numbers = "ordinal",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true -- use a "true" to enable the default, or set your own character
            }
        }
    }
}
EOF

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
highlight ColorColumn ctermbg=7
set backspace=indent,eol,start
set relativenumber
set ruler
set number
set incsearch
set scrolloff=14

" TODO: undodirectory??

" let RipGrep derive root from git project root
if executable('rg')
    let g:rg_derive_root='true'
endif

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
"
" toggle nvim tree
nnoremap <silent><leader>t :NvimTreeToggle<CR>
" toggle indent guide
nnoremap <silent><leader>i :IndentBlanklineToggle<CR>

" toggle nvim tree
nnoremap <silent><leader>t :NvimTreeToggle<CR>

" start up zen mode (focus mode) 
nnoremap <silent><leader>z :ZenMode<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fd :Telescope find_files cwd=
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" toggle tree sitter context
nnoremap <silent><leader>c :TSContextToggle<CR>

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

" cycle between buffers
nnoremap <silent><s-h> :BufferLineCycleNext<CR>
nnoremap <silent><s-l> :BufferLineCyclePrev<CR>


" Go to buffer based on ordinal number
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

" enter last terminal command
nnoremap <leader><F1> :execute "!!"<CR>

" open vimrc in new buffer
nnoremap <leader>v :e $MYVIMRC<CR>

" keep cursor centered when doing half page up or down
nnoremap <silent><c-d> <c-d>zz
nnoremap <silent><c-u> <c-u>zz
