-- LSP Configuration using new vim.lsp.config API (Neovim 0.11+)

-- Enable snippet capability for completion (use cmp capabilities when available)
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = ok_cmp and cmp_lsp.default_capabilities()
    or vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Apply to every LSP server
vim.lsp.config("*", { capabilities = capabilities })

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
-- schemastore.nvim: full up-to-date SchemaStore catalog
-- yaml-companion: per-buffer schema switching (:Telescope yaml_schema)
--                 + auto-detects Kubernetes manifests by content
local ok_ss, schemastore = pcall(require, "schemastore")
local yamlls_settings = {
  redhat = { telemetry = { enabled = false } },
  yaml = {
    validate = true,
    completion = true,
    hover = true,
    keyOrdering = false,
    format = { enable = true },
    -- schemastore.nvim replaces the builtin store (url must be empty string)
    schemaStore = { enable = false, url = "" },
    schemas = ok_ss and schemastore.yaml.schemas() or {},
  },
}

-- nvim 0.12 compatibility shims for yaml-companion (must load first)
local yc_compat = require("yaml-companion-compat")

local ok_yc, yaml_companion = pcall(require, "yaml-companion")
if ok_yc then
  vim.lsp.config.yamlls = yc_compat.fix(yaml_companion.setup({
    builtin_matchers = {
      kubernetes = { enabled = true },
    },
    lspconfig = {
      capabilities = capabilities,
      settings = yamlls_settings,
      on_attach = yc_compat.on_attach,
    },
  }))
else
  vim.lsp.config.yamlls = { settings = yamlls_settings }
end

-- YAML files that match no schema fall back to Kubernetes
-- (schemastore filename matches and content auto-detection take priority)
local k8s_schema = {
  name = "Kubernetes",
  uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.36.0-standalone-strict/all.json",
}
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or client.name ~= "yamlls" then return end
    vim.defer_fn(function()
      if not vim.api.nvim_buf_is_valid(ev.buf) then return end
      local ok, yc = pcall(require, "yaml-companion")
      if not ok then return end
      local schema = yc.get_buf_schema(ev.buf)
      local cur = schema and schema.result and schema.result[1]
      if not cur or cur.name == "none" then
        yc.set_buf_schema(ev.buf, k8s_schema)
      end
    end, 2000)
  end,
})

-- Helm (helm_ls drives yamlls inside templates for k8s completion)
vim.lsp.config.helm_ls = {
  settings = {
    ["helm-ls"] = {
      valuesFiles = {
        mainValuesFile = "values.yaml",
        additionalValuesFilesGlobPattern = "values*.yaml",
      },
      yamlls = {
        enabled = true,
        path = "yaml-language-server",
      },
    },
  },
}

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

-- Swift (SourceKit-LSP)
vim.lsp.config.sourcekit = {}

-- gh actions
vim.lsp.config.gh_actions_ls = {
  filetypes = { "yaml.ghaction" }
}

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
  'sourcekit',
  'helm_ls',
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
