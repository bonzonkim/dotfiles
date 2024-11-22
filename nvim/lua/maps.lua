local keymap = vim.keymap

-- Do not yank with x
keymap.set('n', 'x', '"_x')

-- New tab
keymap.set('n', 'te', ':tabedit')

--netrw
keymap.set('n', 'net', ':Ve')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')
keymap.set('v', '<C-c>', '')

vim.cmd([[
  vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
]])

-- Move tabs
-- Comment lines below if you are using bufferline
vim.keymap.set('n', '<Tab>', '<Cmd>tabnext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>tabprevious<CR>', {})
