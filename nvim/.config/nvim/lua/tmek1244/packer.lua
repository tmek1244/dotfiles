-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                            , branch = '0.1.x',
	  requires = {
          {'nvim-lua/plenary.nvim'},
          {'BurntSushi/ripgrep'},
          {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      }
  }

  use {
	"catppuccin/nvim",
	as = "catppuccin"
  }

  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = function()
		  local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		  ts_update()
	  end,
  }

  use 'nvim-treesitter/nvim-treesitter-context'

  use {
      'nvim-tree/nvim-tree.lua',
      requires = {
          'nvim-tree/nvim-web-devicons', -- optional
      },
  }

  use('mbbill/undotree')

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment these if you want to manage the language servers from neovim
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},

          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'saadparwaiz1/cmp_luasnip'},
          {'L3MON4D3/LuaSnip'},
          {'rafamadriz/friendly-snippets'},
	  }
  }

  use 'tmek1244/nvim-lspconfig'

  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  }

  use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

  use 'github/copilot.vim'
  use 'knubie/vim-kitty-navigator'
  use 'lewis6991/gitsigns.nvim'

  use 'numToStr/Comment.nvim'

  --use {
  --    'nvimdev/dashboard-nvim',
  --    event = 'VimEnter',
  --    config = function()
  --        require('dashboard').setup {
  --          theme = 'hyper',
  --        }
  --    end,
  --    requires = {'nvim-tree/nvim-web-devicons'}
 -- }


end)

