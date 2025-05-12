-- lua/lazy_setup.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  -- Lazy plugin spec list
  { "neovim/nvim-lspconfig" },
  { "nvimdev/lspsaga.nvim" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "nvim-lualine/lualine.nvim" },
  { "windwp/nvim-ts-autotag" },
  { "windwp/nvim-autopairs" },
  { "kyazdani42/nvim-web-devicons" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  { "lukas-reineke/indent-blankline.nvim" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "mfussenegger/nvim-jdtls" },
  { "nvim-lua/plenary.nvim" },
  { "onsails/lspkind.nvim" },
  { "kburdett/vim-nuuid" },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  { "akinsho/nvim-bufferline.lua" },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup()
    end,
  },
  { "folke/tokyonight.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "iamcco/markdown-preview.nvim" },
  { "tidalcycles/vim-tidal" },
  { "brenoprata10/nvim-highlight-colors" },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "saadparwaiz1/cmp_luasnip" }
  },
  { "saadparwaiz1/cmp_luasnip" },
  { "towolf/vim-helm" },
  { "mfussenegger/nvim-ansible" },
  { "karb94/neoscroll.nvim" },
  { "jake-stewart/multicursor.nvim", branch = "1.0" },
  { "bluz71/vim-moonfly-colors", name = "moonfly" },
  { "EdenEast/nightfox.nvim" },
  { "Tsuzat/NeoSolarized.nvim" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              bo = {
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  { "ray-x/go.nvim" },
  { "ray-x/guihua.lua" },
  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
  },
}, {
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true },
})

