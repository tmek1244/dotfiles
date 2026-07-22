return {
    {
        'sindrets/diffview.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewFileHistory",
            "DiffviewRefresh",
        },
        keys = {
            {
                '<leader>gv',
                function()
                    -- DiffviewOpen has no toggle of its own.
                    local view = require('diffview.lib').get_current_view()
                    if view then vim.cmd('DiffviewClose') else vim.cmd('DiffviewOpen') end
                end,
                desc = 'Diffview: toggle working tree diff',
            },
            { '<leader>gh', '<cmd>DiffviewFileHistory<cr>',   desc = 'Diffview: repo history' },
            { '<leader>gf', '<cmd>DiffviewFileHistory %<cr>', desc = 'Diffview: current file history' },
        },
        opts = {
            enhanced_diff_hl = true,
            view = {
                merge_tool = {
                    layout = "diff3_mixed",
                    disable_diagnostics = true,
                },
            },
        },
    },
}
