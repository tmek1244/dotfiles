return {
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        config = function()
            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"
            
                --local function opts(desc)
                --  return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                --end
            
                -- default mappings
                api.config.mappings.default_on_attach(bufnr)
            
                -- custom mappings
                vim.keymap.set('n', '<leader>e', api.tree.toggle)
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
