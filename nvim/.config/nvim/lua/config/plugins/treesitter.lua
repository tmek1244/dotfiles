return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdate", "TSUpdateSync", "TSInstall", "TSInstallSync", "TSModuleInfo" },
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "c", "cpp", "lua", "vim", "vimdoc", "query",
                    "python", "javascript", "typescript", "tsx", "html", "css",
                    "terraform", "hcl", "json", "yaml", "toml",
                    "jinja", "jinja_inline", "htmldjango",
                    "bash", "regex", "markdown", "markdown_inline",
                    "gitcommit", "git_rebase", "diff",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
