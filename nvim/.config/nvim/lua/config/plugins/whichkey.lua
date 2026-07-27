return {
    {
        'folke/which-key.nvim',
        event = "VeryLazy",
        opts = {
            preset = "helix",
            -- Grouped by task rather than by which plugin happens to provide it:
            -- everything git lives under <leader>g whether it comes from
            -- telescope or diffview, and <leader>x covers acting on the code in
            -- front of you (format, lint, diagnostics).
            spec = {
                { "<leader>f", group = "find" },
                { "<leader>g", group = "git" },
                { "<leader>h", group = "git hunk" },
                { "<leader>n", group = "noice" },
                { "<leader>t", group = "tabs" },
                { "<leader>x", group = "code / fix" },
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
