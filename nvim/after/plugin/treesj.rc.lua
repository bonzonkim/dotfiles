local status, treesj = pcall(require, "treesj")
if not status then return end

treesj.setup({})

vim.keymap.set("n", "<C-m>", treesj.toggle, { desc = "Toggle Join/Split" })
