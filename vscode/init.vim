" set leader key to be SPACEBAR
let mapleader=" "

" turn off highlights (after searching)
nnoremap <silent><leader>h :noh<CR>

" center cursor on half page movement
nnoremap <c-d> <C-d>zz
nnoremap <c-u> <C-u>zz

" window navigation
nnoremap <c-j> <Cmd>:call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <c-j> <Cmd>:call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <c-k> <Cmd>:call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
xnoremap <c-k> <Cmd>:call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nnoremap <c-h> <Cmd>:call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
xnoremap <c-h> <Cmd>:call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap <c-l> <Cmd>:call VSCodeNotify('workbench.action.focusRightGroup')<CR>
xnoremap <c-l> <Cmd>:call VSCodeNotify('workbench.action.focusRightGroup')<CR>

" move between vscode tabs in group
nnoremap <s-l> <Cmd>Tabnext<CR>
nnoremap <s-h> <Cmd>Tabprevious<CR>

inoremap jk <esc>
inoremap kj <esc>
