return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        cmd = 'Telescope',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
        },
        -- Declared here rather than in config() so lazy.nvim can defer the plugin
        -- until one of them is pressed.
        keys = {
            {
                '<leader>ff',
                function()
                    require('telescope.builtin').find_files({
                        hidden = true,
                        file_ignore_patterns = { '.git' }
                    })
                end,
                desc = 'Find files',
            },
            {
                '<C-p>',
                function() require('telescope.builtin').git_files() end,
                desc = 'Find git files',
            },
            {
                '<leader>fg',
                function() require('telescope.builtin').git_status() end,
                desc = 'Git status',
            },
            {
                '<leader>fs',
                function() require('config.telescope.multigrep').live_multigrep() end,
                desc = 'Live multigrep (pattern␣␣file␣␣!exclude)',
            },
        },
        config = function()
            require('telescope').setup {
                pickers = {
                    find_files = {
                        -- theme = "dropdown"
                    }
                },
                extensions = {
                    fzf = {}
                }
            }

            require('telescope').load_extension('fzf')
            pcall(require('telescope').load_extension, 'noice')

            vim.api.nvim_create_autocmd("User", {
                pattern = "TelescopePreviewerLoaded",
                callback = function(args)
                    vim.wo.wrap = true
                end,
            })
        end
    }
}
