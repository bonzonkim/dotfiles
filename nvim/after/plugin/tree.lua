local status, tree = pcall(require, "nvim-tree")
if (not status) then return end

require("nvim-tree").setup()
vim.keymap.set('n', '<C-f>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
