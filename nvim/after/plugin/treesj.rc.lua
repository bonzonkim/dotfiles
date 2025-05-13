local status, treesj = pcall(require, "treesj")
if not status then return end

treesj.setup({
  max_join_length = 240,
})

vim.keymap.set("n", "<C-q>", treesj.toggle, { desc = "Toggle Join/Split" })
