local status, go = pcall(require, 'go')
if not status then return end
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})

go.setup({
  lsp_inlay_hints = {
    enable = false,
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})
