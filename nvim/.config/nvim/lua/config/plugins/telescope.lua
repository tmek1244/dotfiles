return {
    {
        'nvim-telescope/telescope.nvim',
        -- Latest release rather than a branch: 0.1.x predates the nvim-treesitter
        -- `main` rewrite and drives previews through the API that branch dropped,
        -- so its previews raise `ft_to_lang (a nil value)` on every file.
        version = '*',
        cmd = 'Telescope',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
        },
        -- Declared here rather than in config() so lazy.nvim can defer the plugin
        -- until one of them is pressed.
        keys = {
            {
                '<leader>ff',
                function()
                    require('telescope.builtin').find_files({
                        hidden = true,
                        file_ignore_patterns = { '.git' }
                    })
                end,
                desc = 'Find files',
            },
            {
                '<C-p>',
                function() require('telescope.builtin').git_files() end,
                desc = 'Find git files',
            },
            {
                '<leader>gs',
                function() require('telescope.builtin').git_status() end,
                desc = 'Git status',
            },
            {
                '<leader>gb',
                function()
                    local actions = require('telescope.actions')
                    require('telescope.builtin').git_branches({
                        -- `pattern` is passed as the last argv to `git for-each-ref`,
                        -- where git still parses it as an option. Telescope itself
                        -- passes no --sort, so branches would come out alphabetical.
                        pattern = '--sort=-committerdate',
                        -- The picker sizes its columns to the longest branch name,
                        -- so a side-by-side preview pushes author/date out of view.
                        -- Stacking gives the results the full window width.
                        layout_strategy = 'vertical',
                        layout_config = { preview_height = 0.4 },
                        -- Composed after the picker's own mappings, so these win.
                        -- The picker takes <C-d> for delete-branch, shadowing the
                        -- default preview scroll; give the key back and put the
                        -- destructive action somewhere it can't be hit by reflex.
                        attach_mappings = function(_, map)
                            map({ 'i', 'n' }, '<C-d>', actions.preview_scrolling_down)
                            map({ 'i', 'n' }, '<M-d>', actions.git_delete_branch)
                            return true
                        end,
                    })
                end,
                desc = 'Git branches (recent first)',
            },
            {
                '<leader>fs',
                function() require('config.telescope.multigrep').live_multigrep() end,
                desc = 'Live multigrep (pattern␣␣file␣␣!exclude)',
            },
            -- Reopen a picker where it was left: same prompt, same results, same
            -- multi selections. Works for every picker above, multigrep included.
            {
                '<leader>fr',
                function() require('telescope.builtin').resume() end,
                desc = 'Resume last picker',
            },
            {
                '<leader>fp',
                function() require('telescope.builtin').pickers() end,
                desc = 'Previous pickers',
            },
        },
        config = function()
            require('telescope').setup {
                defaults = {
                    -- Keep enough history for <leader>fp to be worth opening;
                    -- the default of 1 only ever holds the picker <leader>fr
                    -- would resume anyway. Each one keeps its results and multi
                    -- selections in memory, capped at limit_entries (1000).
                    cache_picker = { num_pickers = 10 },
                },
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
            pcall(require('telescope').load_extension, 'noice')

            vim.api.nvim_create_autocmd("User", {
                pattern = "TelescopePreviewerLoaded",
                callback = function(args)
                    vim.wo.wrap = true
                end,
            })
        end
    }
}
