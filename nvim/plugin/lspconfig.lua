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
-- nvim_lsp.tsserver.setup {
--   -- on_attach = on_attach,
--   filetypes = { "typescript", "typescriptreact", "typescript.tsx","javascript", "javascriptreact" },
--   cmd = { "typescript-language-server", "--stdio" }
-- }

nvim_lsp.ts_ls.setup {}
nvim_lsp.tailwindcss.setup { filetypes = { 'css','templ' } }
nvim_lsp.pyright.setup {}
nvim_lsp.gopls.setup{}
nvim_lsp.yamlls.setup{}
nvim_lsp.lua_ls.setup{}
nvim_lsp.htmx.setup{}

nvim_lsp.bashls.setup{
    cmd = { "bash-language-server", "start" },
    filetypes={ "sh" }
}
nvim_lsp.templ.setup{
  cmd = { 'templ', 'lsp' },
  filetypes = { 'templ' },
}

vim.cmd([[
  autocmd BufRead,BufNewFile *.tf set filetype=terraform
  autocmd BufRead,BufNewFile *.tfvars set filetype=terraform
]])

nvim_lsp.terraformls.setup{}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})
