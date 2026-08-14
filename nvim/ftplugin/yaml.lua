-- yamlls configuration lives in plugin/lspconfig.lua (schemastore + yaml-companion)

-- Pick a schema for the current buffer
vim.keymap.set("n", "<leader>ys", "<cmd>Telescope yaml_schema<CR>",
  { buffer = true, desc = "Select YAML schema" })

-- Autocompletion
local cmpStatus, cmp = pcall(require, "cmp")
if not cmpStatus then return end

cmp.setup.buffer {
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
  },
}
