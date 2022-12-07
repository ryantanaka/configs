" set leader key to be SPACEBAR
let mapleader=" "

" turn off highlights (after searching)
nnoremap <silent><C>h :noh<CR>

" window navigation
nnoremap <C-j> <Cmd>:call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <C-j> <Cmd>:call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <c-k> <Cmd>:call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
xnoremap <c-k> <Cmd>:call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nnoremap <c-h> <Cmd>:call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
xnoremap <c-h> <Cmd>:call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap <c-l> <Cmd>:call VSCodeNotify('workbench.action.focusRightGroup')<CR>
xnoremap <c-l> <Cmd>:call VSCodeNotify('workbench.action.focusRightGroup')<CR>