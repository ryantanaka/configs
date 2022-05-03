 " PLUGINS #####################################################################
call plug#begin()
Plug 'nvim-lua/plenary.nvim' " lua functions required by telescope and others
Plug 'nvim-telescope/telescope.nvim' " fuzzy search + ripgrep
Plug 'windwp/nvim-autopairs' " completes brackets, parenthesis, etc
Plug 'lukas-reineke/indent-blankline.nvim' " show indent guide
Plug 'tpope/vim-commentary' " gcc to cmt line (takes count), gc to comment target of motion (or visual)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " parser generater used by other plugins and themes
Plug 'EdenEast/nightfox.nvim' " love this colorscheme!
Plug 'nvim-neorg/neorg' " org mode
Plug 'folke/zen-mode.nvim' " focus mode (similar to Goyo)
call plug#end()

" SETUP #######################################################################
lua require("zen-mode").setup{}

" setup autopairs to autocomplete ({[ etc
lua require('nvim-autopairs').setup{}

" norg setup (required before tree-sitter setup)
lua <<EOF
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"norg", "python", "bash"},
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

lua << EOF
require('neorg').setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.norg.concealer"] = {}, -- Allows for use of icons
    },

    hook = function()
        -- This sets the leader for all Neorg keybinds. It is separate from the regular <Leader>,
        -- And allows you to shove every Neorg keybind under one "umbrella".
        local neorg_leader = "<Leader>" -- You may also want to set this to <Leader>o for "organization"

        -- Require the user callbacks module, which allows us to tap into the core of Neorg
        local neorg_callbacks = require('neorg.callbacks')

        -- Listen for the enable_keybinds event, which signals a "ready" state meaning we can bind keys.
        -- This hook will be called several times, e.g. whenever the Neorg Mode changes or an event that
        -- needs to reevaluate all the bound keys is invoked
        neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)

            -- Map all the below keybinds only when the "norg" mode is active
            keybinds.map_event_to_mode("norg", {
                n = { -- Bind keys in normal mode
                    -- Keys for managing TODO items and setting their states
                    { "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle" }
                },
            }, { silent = true, noremap = true })

        end)
    end
}
EOF

" COLORSCHEME #################################################################
set termguicolors
colorscheme nordfox

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

" keep an undo directory
if !isdirectory($HOME."/.nvim")
    call mkdir($HOME."/.nvim", "", 0770)
endif
if !isdirectory($HOME."/.nvim/undo-dir")
    call mkdir($HOME."/.nvim/undo-dir", "", 0700)
endif
set undodir=~/.nvim/undodir
set undofile

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
" toggle indent guide
nnoremap <silent><leader>i :IndentBlanklineToggle<CR>

" start up zen mode (focus mode) 
nnoremap <silent><leader>z :ZenMode<CR>

" convenient buffer switching (hit TAB to cycle through tabs)
nnoremap <leader>b :b<SPACE>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fd :Telescope find_files cwd=
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


" cycle between buffers
nnoremap <silent><leader>. :BufferLineCycleNext<CR>
nnoremap <silent><leader>, :BufferLineCyclePrev<CR>

" enter last terminal command
nnoremap <leader>1 :execute "!!"<CR>

" open vimrc in new buffer
nnoremap <leader>v :e $MYVIMRC<CR>

" python3 scratch file setup
let HOME = $HOME
let PYSCRATCH_DIR = $HOME . "/.py-scratch"
let PYSCRATCH_FILE = PYSCRATCH_DIR . "/scratch.py"
echo PYSCRATCH_FILE
if !isdirectory(PYSCRATCH_DIR)
    call mkdir(PYSCRATCH_DIR, "", 0770)
endif
if !filereadable(PYSCRATCH_FILE)
    call writefile(["#!/usr/bin/env python3"], expand(PYSCRATCH_FILE))
endif
nnoremap <expr> <leader>s ":e " . PYSCRATCH_FILE . "<CR>"

" execute current buffer as python3 script 
:function RunCurrentBufferAsPythonScript()
:  let file_ext = tolower(expand('%:e'))
:  if file_ext == "py"
:    execute "! python3 %" 
:  else
:    echohl WarningMsg
:    echo "Warning"
:    echohl None
:    echon ": no .py extension detected, won't run as python3 script"
:  endif
:endfunction

" invoke buffer as python3 script
nnoremap <leader>2 :call RunCurrentBufferAsPythonScript()<CR>


