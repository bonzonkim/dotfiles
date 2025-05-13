--require("lspconfig").yamlls.setup {
--  settings = {
--    yaml = {
--      schemas = {
--        kubernetes = "k8s-*.yaml",
--        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
--        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
--        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
--        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
--        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
--        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
--        ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
--      },
--    },
--  },
--}

-- LSP Configuration
local lspStatus, lsp = pcall(require, "lspconfig")
if not lspStatus then return end
lsp.yamlls.setup {
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.0-standalone-strict/all.json"] = {
          "*.yaml",
          "*.yml",
          "*/kubernetes/*.yaml",
          "*/kubernetes/*.yml",
          "*/kube/*.yaml",
          "*/kube/*.yml",
        },
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
        ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
      },
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      validate = true,
      completion = true,
      hover = true,
    },
  },
}


-- Autocompletion
local cmpStatus, cmp = pcall(require, "cmp")
if not cmpStatus then return end

cmp.setup.buffer {
  sources = {
    { name = "vsnip" },
    { name = "nvim_lsp" },
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
