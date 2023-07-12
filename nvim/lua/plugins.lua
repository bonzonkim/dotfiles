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
--  use 'Exafunction/codeium.vim'
  
  --Wildcat
    use {
        'javiorfo/nvim-wildcat',
        requires = 'javiorfo/nvim-popcorn'
    }

  --Telescope
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  } 

  use 'akinsho/nvim-bufferline.lua'

    

end)
