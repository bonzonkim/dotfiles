local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({

})

-- nvim-treesitter main needs the tree-sitter CLI to build parsers; mason puts its bin dir on nvim's PATH
require("mason-registry").refresh(function()
  local ok, ts_cli = pcall(require("mason-registry").get_package, "tree-sitter-cli")
  if ok and not ts_cli:is_installed() then ts_cli:install() end
end)

lspconfig.setup {
  ensure_installed = { "ts_ls", "tailwindcss", "pyright", "terraformls" },
}
