local status, ts = pcall(require, "nvim-treesitter")
if (not status) then return end
vim.filetype.add({
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})

ts.install({
  "go",
  "tsx",
  "toml",
  "php",
  "python",
  "json",
  "yaml",
  "css",
  "html",
  "lua",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if not pcall(vim.treesitter.start, args.buf) then return end
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.treesitter.query.get(lang, "indents") then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
