return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
        },
        config = function()
            require('telescope').setup {
                pickers = {
                  find_files = {
                    -- theme = "dropdown"
                  }
                },
                extensions = {
                  fzf = {}
                }
            }
        
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('noice')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', function()
                builtin.find_files({
                    hidden = true,
                    file_ignore_patterns = { '.git' }
                })
            end, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.git_status, {})
    
            require "config.telescope.multigrep".setup()
        end
    }
}