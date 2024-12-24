return {
    {
        'rmagatti/auto-session',
        lazy = false,
      
        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        config = function() 
            local function change_nvim_tree_dir()
                local nvim_tree = require("nvim-tree")
                nvim_tree.change_dir(vim.fn.getcwd())
            end
            
            require("auto-session").setup({
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
                post_restore_cmds = { change_nvim_tree_dir, "NvimTreeOpen" },
                pre_save_cmds = { "NvimTreeClose" },
            })
        end   
    }
}