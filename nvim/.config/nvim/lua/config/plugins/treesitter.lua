local parsers = {
    "c", "cpp", "lua", "vim", "vimdoc", "query",
    "python", "javascript", "typescript", "tsx", "html", "css",
    "terraform", "hcl", "json", "yaml", "toml",
    "jinja", "jinja_inline", "htmldjango",
    "bash", "regex", "markdown", "markdown_inline",
    "gitcommit", "git_rebase", "diff",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- `main` is the rewrite and the only branch supporting Nvim 0.12. `master`
        -- is frozen at 0.11: it registers its query directives with `all = false`,
        -- an option 0.12 dropped, so they receive node lists where they expect a
        -- single node and crash on the first markdown fenced code block.
        branch = "main",
        -- The rewrite does not support lazy-loading.
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install(parsers)

            -- `main` only ships parsers and queries; wiring them to the features
            -- Nvim builds on top is the config's job now.
            vim.api.nvim_create_autocmd("FileType", {
                desc = "Enable treesitter highlighting and indentation",
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)
                    if not lang or not vim.treesitter.language.add(lang) then
                        return
                    end

                    vim.treesitter.start(ev.buf, lang)

                    -- Only for languages that ship an indents query, so the rest
                    -- keep whatever indent Nvim's own ftplugin set up.
                    if vim.treesitter.query.get(lang, "indents") then
                        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end
    }
}
