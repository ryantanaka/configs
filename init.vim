 " PLUGINS #####################################################################
call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim' " lua functions required by telescope and others
Plug 'nvim-telescope/telescope.nvim' " fuzzy search + ripgrep
Plug 'windwp/nvim-autopairs' " completes brackets, parenthesis, etc
Plug 'lukas-reineke/indent-blankline.nvim' " show indent guide
Plug 'tpope/vim-commentary' " gcc to cmt line (takes count), gc to comment target of motion (or visual)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " parser generater used by other plugins and themes
Plug 'EdenEast/nightfox.nvim' " love this colorscheme!
Plug 'ryanoasis/vim-devicons' " icon pack 
Plug 'akinsho/bufferline.nvim' " show my buffers at the top like tabs
Plug 'kyazdani42/nvim-tree.lua' " file tree explorer
Plug 'mbbill/undotree' " undotree visualizer
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

" nvim-tree setup
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_refresh_wait = 500 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

lua <<EOF
require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close          = false,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir   = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = false,
  -- show lsp diagnostics in the signcolumn
  lsp_diagnostics     = false,
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = false,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  }
}
EOF

lua require("bufferline").setup{}

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
set backspace=indent,eol,start
set relativenumber
set ruler
set number
set incsearch

" keep an undo directory
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undodir
set undofile

" toggle undo tree
nnoremap <F5> :UndotreeToggle<CR>

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

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>tr :NvimTreeRefresh<CR> 
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus and NvimTreeResize are also available if you need them

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


