return {
    {
        'nvim-tree/nvim-tree.lua',
        cmd = { "NvimTreeOpen", "NvimTreeClose", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        -- Global, so the tree can be opened the first time. Previously this lived
        -- in on_attach and therefore only existed once the tree was already open.
        keys = {
            {
                '<leader>e',
                function() require('nvim-tree.api').tree.toggle() end,
                desc = 'Toggle file tree',
            },
        },
        config = function()
            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"

                --local function opts(desc)
                --  return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                --end

                -- default mappings
                api.config.mappings.default_on_attach(bufnr)

                --vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
            end


            require("nvim-tree").setup({
              sort = {
                sorter = "case_sensitive",
              },
              view = {
                width = 30,
              },
              renderer = {
                group_empty = true,
              },
              filters = {
                git_ignored = false,
                custom = { "^.git$" }
              },
              on_attach = my_on_attach,
            })
        end
    }
}
