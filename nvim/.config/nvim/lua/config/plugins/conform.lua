-- Filetypes where no external formatter applies AND the language server must not
-- be used as a fallback: the HTML server reflows Jinja templates as if the
-- `{% ... %}` blocks were plain text, flattening the indentation inside them.
local no_lsp_fallback = {
    htmldjango = true,
    jinja = true,
    ["yaml.ansible"] = true,
}

local function lsp_format_for(bufnr)
    return no_lsp_fallback[vim.bo[bufnr or 0].filetype] and "never" or "fallback"
end

return {
    {
        'stevearc/conform.nvim',
        event = { "BufWritePre" },
        cmd = { "ConformInfo", "FormatEnable", "FormatDisable" },
        keys = {
            {
                '<F3>',
                function()
                    require('conform').format({ async = true, lsp_format = lsp_format_for() })
                end,
                mode = { 'n', 'x' },
                desc = 'Format buffer',
            },
        },
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    lua = { 'stylua' },
                    -- ruff_organize_imports then ruff_format, matching `ruff check --fix`.
                    python = { 'ruff_organize_imports', 'ruff_format' },
                    javascript = { 'prettierd', 'prettier', stop_after_first = true },
                    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
                    typescript = { 'prettierd', 'prettier', stop_after_first = true },
                    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
                    json = { 'prettierd', 'prettier', stop_after_first = true },
                    jsonc = { 'prettierd', 'prettier', stop_after_first = true },
                    css = { 'prettierd', 'prettier', stop_after_first = true },
                    scss = { 'prettierd', 'prettier', stop_after_first = true },
                    html = { 'prettierd', 'prettier', stop_after_first = true },
                    yaml = { 'prettierd', 'prettier', stop_after_first = true },
                    markdown = { 'prettierd', 'prettier', stop_after_first = true },
                    terraform = { 'terraform_fmt' },
                    hcl = { 'terraform_fmt' },
                    -- Deliberately absent: htmldjango/jinja and yaml.ansible, see
                    -- no_lsp_fallback above.
                },

                -- Off by default: <F3> formats on demand. `:FormatEnable` turns on
                -- format-on-save, `:FormatDisable` turns it back off.
                format_on_save = function(bufnr)
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return nil
                    end
                    return { timeout_ms = 1000, lsp_format = lsp_format_for(bufnr) }
                end,
            })

            vim.g.disable_autoformat = true

            vim.api.nvim_create_user_command('FormatDisable', function(args)
                if args.bang then
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, { desc = 'Disable format-on-save (! for current buffer only)', bang = true })

            vim.api.nvim_create_user_command('FormatEnable', function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, { desc = 'Enable format-on-save' })
        end,
    },
}
