return {
	{
		"catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000,
		config = function()
			require("catppuccin").setup({
                flavour = "macchiato",
                integrations = {
                    cmp = true,
                    treesitter = true,
                    telescope = {
                        enabled = true,
                    },
                    gitsigns = true,
                },
                highlight_overrides = {
                    all = function(colors)
                        return {
                            GitSignsChange = { fg = colors.blue },
                        }
                    end
                },
            })
            
            vim.cmd.colorscheme "catppuccin"            
		end
	},
}