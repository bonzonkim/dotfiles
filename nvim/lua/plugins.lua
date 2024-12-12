local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Your plugins go here

  -- lspconfig and imporve hover
  use 'neovim/nvim-lspconfig'
  use 'nvimdev/lspsaga.nvim'

  -- cmp makes autocompletion better
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/nvim-cmp' -- A completion engine plugin for neovim

  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'windwp/nvim-ts-autotag' -- autoclose and autorename html tag
  use 'windwp/nvim-autopairs' -- for closing brackets.

  use 'kyazdani42/nvim-web-devicons' -- File icons
  use {
    'nvim-treesitter/nvim-treesitter', -- language parser for syntax highlightings
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
--  use 'nvim-tree/nvim-tree.lua'

  use "lukas-reineke/indent-blankline.nvim" -- Indent hightlighting

  -- LSP installer
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  
  --jdtls
  use 'mfussenegger/nvim-jdtls'
  use 'nvim-lua/plenary.nvim'

  use 'onsails/lspkind.nvim'

  use 'kburdett/vim-nuuid' -- generate UUID

  --Codeium
  --use 'Exafunction/codeium.vim'
  
  --Telescope
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  } 

  use 'akinsho/nvim-bufferline.lua'
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  require("toggleterm").setup()
  end}

  use 'folke/tokyonight.nvim' 
  use 'rebelot/kanagawa.nvim'
  use 'iamcco/markdown-preview.nvim'
  use 'tidalcycles/vim-tidal'
  use 'brenoprata10/nvim-highlight-colors'

  use {
   'L3MON4D3/LuaSnip',
    --after = 'nvim-cmp',
    --config = function() require('config.snippets')end,
    requires = { 'saadparwaiz1/cmp_luasnip' }
  }

--  use({
--    "glacambre/firenvim",
--    run = function() fn["firenvim#install"](0) end,
--    opt = true,
--    setup = [[vim.cmd('packadd firenvim')]],
--  })
  use { 'glacambre/firenvim' }

  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'towolf/vim-helm' }
  use { 'mfussenegger/nvim-ansible' }

  use { 'karb94/neoscroll.nvim' }

  use { "jake-stewart/multicursor.nvim", branch = "1.0" }
  use { "bluz71/vim-moonfly-colors", name = "moonfly" }
  use { "EdenEast/nightfox.nvim" }
  use {'Tsuzat/NeoSolarized.nvim'}

  use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      requires = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
          {
              's1n7ax/nvim-window-picker',
              version = '2.*',
              config = function()
                  require 'window-picker'.setup({
                      filter_rules = {
                          include_current_win = false,
                          autoselect_one = true,
                          bo = {
                              filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                              buftype = { 'terminal', "quickfix" },
                          },
                      },
                  })
              end,
          },
      }
  }
    
end)

