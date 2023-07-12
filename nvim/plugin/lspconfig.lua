local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end
local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end
end


--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.html.setup {
 capabilities = capabilities, 
}
--html
require'lspconfig'.html.setup {}



-- TypeScript
nvim_lsp.tsserver.setup {
  -- on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx","javascript", "javascriptreact" },
  cmd = { "typescript-language-server", "--stdio" }
}



nvim_lsp.tailwindcss.setup {}
nvim_lsp.pyright.setup {}
nvim_lsp.terraformls.setup {}
nvim_lsp.gopls.setup{}




-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--   pattern = {"*.tf", "*.tfvars"},
--   callback = vim.lsp.buf.formatting_sync,
-- })
