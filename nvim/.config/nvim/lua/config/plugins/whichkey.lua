return {
    {
        'folke/which-key.nvim',
        event = "VeryLazy",
        opts = {
            preset = "helix",
            spec = {
                { "<leader>f", group = "find" },
                { "<leader>h", group = "git hunk" },
                { "<leader>g", group = "git / diagnostics" },
                { "<leader>n", group = "noice" },
                { "<leader>l", group = "look up" },
            },
        },
        keys = {
            {
                '<leader>?',
                function() require('which-key').show({ global = false }) end,
                desc = 'Buffer local keymaps',
            },
        },
    },
}
