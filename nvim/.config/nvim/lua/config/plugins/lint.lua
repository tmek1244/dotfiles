local python = require('config.python')

-- Only run what the project itself ships (see config/python.lua), so this stays
-- inert in projects that have no mypy/flake8 and there is nothing to configure
-- per machine.
local python_linters = { 'mypy', 'flake8' }

return {
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require('lint')

            for _, name in ipairs(python_linters) do
                lint.linters[name].cmd = function()
                    return python.tool(name) or name
                end
            end

            local function lint_buffer()
                if vim.bo.filetype ~= 'python' then
                    return
                end
                local available = vim.tbl_filter(function(name)
                    return python.tool(name) ~= nil
                end, python_linters)
                if #available > 0 then
                    lint.try_lint(available)
                end
            end

            -- mypy type-checks the whole import graph, so it is far too slow for
            -- TextChanged/InsertLeave. Linting on write (plus once on open) keeps
            -- it in step with how these tools run in CI anyway.
            vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
                group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
                callback = lint_buffer,
            })

            vim.keymap.set('n', '<leader>gl', lint_buffer, { desc = 'Run linters on buffer' })
        end,
    },
}
