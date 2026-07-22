return {
    {
        'rmagatti/auto-session',
        lazy = false,
      
        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        config = function() 
            local function change_nvim_tree_dir()
                -- nvim-tree.api is the only supported entry point; the old
                -- require("nvim-tree").change_dir() was removed upstream.
                require("nvim-tree.api").tree.change_root(vim.fn.getcwd())
            end
            
            require("auto-session").setup({
                log_level = "error",
                suppressed_dirs = { "~/", "~/Downloads", "/" },
                post_restore_cmds = { change_nvim_tree_dir, "NvimTreeOpen" },
                pre_save_cmds = { "NvimTreeClose" },
            })
        end   
    }
}