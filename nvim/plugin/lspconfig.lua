-- LSP Configuration using new vim.lsp.config API (Neovim 0.11+)

-- Enable snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- HTML
vim.lsp.config.html = {
  capabilities = capabilities,
}

-- TypeScript/JavaScript
vim.lsp.config.ts_ls = {}

-- Tailwind CSS
vim.lsp.config.tailwindcss = {
  filetypes = { 'css', 'templ' },
}

-- Python
vim.lsp.config.pyright = {}

-- YAML
vim.lsp.config.yamlls = {}

-- Lua
vim.lsp.config.lua_ls = {}

-- HTMX
vim.lsp.config.htmx = {}

-- Bash
vim.lsp.config.bashls = {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh" },
}

-- Templ
vim.lsp.config.templ = {
  cmd = { 'templ', 'lsp' },
  filetypes = { 'templ' },
}

-- Terraform
vim.lsp.config.terraformls = {}

-- Enable all LSP servers
vim.lsp.enable({
  'html',
  'ts_ls',
  'tailwindcss',
  'pyright',
  'yamlls',
  'lua_ls',
  'htmx',
  'bashls',
  'templ',
  'terraformls',
})

-- Terraform filetype detection
vim.cmd([[
  autocmd BufRead,BufNewFile *.tf set filetype=terraform
  autocmd BufRead,BufNewFile *.tfvars set filetype=terraform
]])

-- Format on save for Terraform files
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end,
})