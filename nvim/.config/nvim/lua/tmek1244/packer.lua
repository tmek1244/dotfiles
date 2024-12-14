-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        -- or                            , branch = '0.1.x',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'BurntSushi/ripgrep' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
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

    use('neovim/nvim-lspconfig')
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')

    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')

    use {
        "ray-x/lsp_signature.nvim",
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    }

    -- use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

    -- use 'github/copilot.vim'
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

    use 'rmagatti/auto-session'

    use 'jiangmiao/auto-pairs'
    use 'Vimjas/vim-python-pep8-indent'

    use {
        "folke/noice.nvim",
        -- event = "VeryLazy",
        opts = {
            -- add any options here
        },
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    }
end)
