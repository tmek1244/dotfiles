return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "LspInfo" },
        dependencies = {
            'saghen/blink.cmp',
            'b0o/SchemaStore.nvim',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            {
                -- mason-lspconfig only manages servers; formatters and linters
                -- need declaring separately so the repo stays reproducible.
                'WhoIsSethDaniel/mason-tool-installer.nvim',
                opts = {
                    ensure_installed = {
                        'stylua',
                        'prettierd',
                        'ansible-lint',
                        -- Deliberately absent: mypy and flake8. They come from the
                        -- project's own virtualenv, see config/python.lua.
                    },
                    run_on_start = true,
                },
            },
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            -- Merged into every server config. mason-lspconfig v2 enables each
            -- installed server itself, so there is no per-server setup() call.
            vim.lsp.config('*', {
                capabilities = require('blink.cmp').get_lsp_capabilities(),
            })

            -- Ruff handles linting/imports; pyright owns types. Turning off ruff's
            -- hover stops the two servers fighting over the hover window.
            --
            -- In a project that ships flake8/mypy those two would report the same
            -- problems in slightly different words, so each server steps aside for
            -- the tool the project actually uses (see config/python.lua). Both
            -- servers keep everything else: ruff still formats and organizes
            -- imports through conform, pyright still drives completion, hover and
            -- go-to-definition. Delete a `before_init` to get the duplicates back.
            local python = require('config.python')

            vim.lsp.config('ruff', {
                on_attach = function(client)
                    client.server_capabilities.hoverProvider = false
                end,
                -- Ruff takes its global settings from initializationOptions, and
                -- `params` is the copy that actually gets sent: the client has
                -- already captured `config.init_options` by the time this runs.
                before_init = function(params, config)
                    if python.tool('flake8', config.root_dir) then
                        local init_options = params.initializationOptions
                        params.initializationOptions = vim.tbl_deep_extend('force',
                            type(init_options) == 'table' and init_options or {},
                            { settings = { lint = { enable = false } } })
                    end
                end,
            })

            vim.lsp.config('pyright', {
                -- Same caveat one server up, mirrored: `client.settings` is a
                -- snapshot of `config.settings` taken before `before_init`, so the
                -- settings pyright answers `workspace/configuration` with can only
                -- be changed on the client itself.
                on_init = function(client)
                    if python.tool('mypy', client.root_dir) then
                        client.settings = vim.tbl_deep_extend('force', client.settings, {
                            python = { analysis = { typeCheckingMode = 'off' } },
                        })
                        client:notify('workspace/didChangeConfiguration', { settings = client.settings })
                    end
                end,
            })

            -- Flask templates are `htmldjango`, but the HTML server only claims
            -- `html` by default.
            vim.lsp.config('html', {
                filetypes = { 'html', 'htmldjango', 'templ' },
            })

            vim.lsp.config('yamlls', {
                settings = {
                    yaml = {
                        -- SchemaStore.nvim supplies the catalog, so yamlls should
                        -- not fetch its own.
                        schemaStore = { enable = false, url = "" },
                        schemas = require('schemastore').yaml.schemas(),
                        keyOrdering = false,
                    },
                },
            })

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'ts_ls',
                    'eslint',
                    'html',
                    'pyright',
                    'ruff',
                    'ansiblels',
                    'yamlls',
                    'clangd',
                    'terraformls',
                    -- 'gopls',
                    'lua_ls',
                },
                -- nvim-lspconfig ships an `lsp/stylua.lua`, so mason-lspconfig
                -- would otherwise start `stylua --lsp` as a server just because
                -- conform's formatter binary is installed.
                automatic_enable = { exclude = { 'stylua' } },
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "<leader>gd", function() vim.diagnostic.open_float() end, opts)

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    -- <F3> formats via conform.nvim (with an LSP fallback), see plugins/conform.lua
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

                    -- require("lsp_signature").on_attach({
                    -- toggle_key = '<A-l>',
                    --     hint_enable = false,
                    -- }, event.buf)
                end,
            })
        end,
    }
}
